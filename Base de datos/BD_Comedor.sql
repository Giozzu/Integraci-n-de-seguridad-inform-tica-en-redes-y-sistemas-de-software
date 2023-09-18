-- RETO: Código para la Base de Datos.
-- Equipo 3

Use master;
GO

IF EXISTS (SELECT 1 FROM sys.databases WHERE [name] = 'ComedorBD')
BEGIN
	ALTER DATABASE ComedorBD SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
	DROP DATABASE ComedorBD;
END;

CREATE DATABASE ComedorBD;
GO


-- DDL (Definición de la estructura)

USE ComedorBD;
GO

DROP TABLE IF EXISTS EstadoComedor;
DROP TABLE IF EXISTS TipoRacion;
DROP TABLE IF EXISTS Sexo;
DROP TABLE IF EXISTS Condicion;
DROP TABLE IF EXISTS Rol;
DROP TABLE IF EXISTS Empleado;
DROP TABLE IF EXISTS Comedor;
DROP TABLE IF EXISTS Menu;
DROP TABLE IF EXISTS Comensal;
DROP TABLE IF EXISTS Asistencia;


-- Catálogo de Estados que tiene un comedor
CREATE TABLE EstadoComedor (
	IDEstadoComedor INT NOT NULL PRIMARY KEY IDENTITY(1,1),
	Nombre VARCHAR(30) NOT NULL UNIQUE
);
GO

-- Catálogo del Tipo de Ración que puede adquirir un comensal
CREATE TABLE TipoRacion (
	IDTipoRacion INT NOT NULL PRIMARY KEY IDENTITY(1,1),
	Tipo VARCHAR(20) NOT NULL UNIQUE,
);
GO

-- Catálogo para el campo "Sexo" para los comensales 
CREATE TABLE Sexo (
	IDSexo INT NOT NULL PRIMARY KEY IDENTITY(1,1),
	Descripcion VARCHAR(30) NOT NULL UNIQUE
);
GO

-- Catálogo de Condiciones para los comensales 
CREATE TABLE Condicion (
	IDCondicion INT NOT NULL PRIMARY KEY IDENTITY(1,1),
	Nombre VARCHAR(30) NOT NULL UNIQUE
);
GO

-- Catálogo de  para los empleados 
CREATE TABLE Rol (
	IDRol INT NOT NULL PRIMARY KEY IDENTITY(1,1),
	Nombre VARCHAR(30) NOT NULL UNIQUE
);
GO

-- Catálogo de Empleados
CREATE TABLE Empleado (
	IDEmpleado INT NOT NULL PRIMARY KEY IDENTITY(1,1),
	IDRol INT NOT NULL,
	CONSTRAINT FK_Empleado_Privilegio FOREIGN KEY (IDRol)
	REFERENCES Rol(IDRol)
	ON UPDATE NO ACTION
	ON DELETE NO ACTION,

	Nombre VARCHAR(30) NOT NULL,
	ApellidoP VARCHAR(30) NOT NULL,
	ApellidoM VARCHAR(30) NOT NULL,
	FechaNacim INT NOT NULL,
	Correo VARCHAR(40) NOT NULL UNIQUE,
	Contraseña VARCHAR(96) NOT NULL UNIQUE
);
GO

-- Catálogo de Comedores 
CREATE TABLE Comedor (
	IDComedor INT NOT NULL PRIMARY KEY IDENTITY(1,1),
	IDEmpleado INT NOT NULL,
	CONSTRAINT FK_Comedor_Empleadoo FOREIGN KEY (IDEmpleado)
	REFERENCES Empleado(IDEmpleado)
	ON UPDATE NO ACTION
	ON DELETE NO ACTION,

	IDEstado INT NOT NULL,
	CONSTRAINT FK_Comedor_EstadoComedor FOREIGN KEY (IDEstado)
	REFERENCES EstadoComedor(IDEstadoComedor)
	ON UPDATE NO ACTION
	ON DELETE NO ACTION,

	Nombre VARCHAR(30) NOT NULL,
	Capacidad INT NOT NULL,
	Direccion VARCHAR(50) NOT NULL,
	Telefono VARCHAR(30) NOT NULL,
	
);
GO

-- Tabla para el Menú
CREATE TABLE Menu (
	IDMenu INT NOT NULL PRIMARY KEY IDENTITY(1,1),
	IDComedor INT NOT NULL, 
	CONSTRAINT FK_Menu_Comedor FOREIGN KEY (IDComedor)
	REFERENCES Comedor(IDComedor)
	ON UPDATE NO ACTION
	ON DELETE NO ACTION,

	Descripcion VARCHAR(50) NOT NULL,
	Precio DECIMAL(10,2) NOT NULL,
	Fecha DATE NOT NULL
); 
GO

-- Tabla para el Registro
CREATE TABLE Comensal (
	IDComensal INT NOT NULL PRIMARY KEY IDENTITY(1,1),
	IDCondicion INT NULL,
	CONSTRAINT FK_Comensal_Condicion FOREIGN KEY (IDCondicion)
	REFERENCES Condicion(IDCondicion)
	ON UPDATE NO ACTION
	ON DELETE NO ACTION,

	Nombre VARCHAR(30) NOT NULL,
	ApellidoP VARCHAR(30) NOT NULL,
	ApellidoM VARCHAR(30) NOT NULL,
	CURP VARCHAR(18) NOT NULL UNIQUE,
	FechaNacim INT NOT NULL,

	IDSexo INT NOT NULL,
	CONSTRAINT FK_Comensal_Sexo FOREIGN KEY (IDSexo)
	REFERENCES Sexo(IDSexo)
	ON UPDATE NO ACTION
	ON DELETE NO ACTION,
);
GO

-- Tabla para la toma de Asistencia
CREATE TABLE Asistencia (
	IDAsistencia INT NOT NULL PRIMARY KEY IDENTITY(1,1),
	IDComedor INT NOT NULL, 
	CONSTRAINT FK_Asistencia_Comedor FOREIGN KEY (IDComedor)
	REFERENCES Comedor(IDComedor)
	ON UPDATE NO ACTION
	ON DELETE NO ACTION,
	
	IDComensal INT NOT NULL,
	CONSTRAINT FK_Asistencia_Comensal FOREIGN KEY (IDComensal)
	REFERENCES Comensal(IDComensal)
	ON UPDATE NO ACTION
	ON DELETE NO ACTION,

	IDTipoRacion INT NOT NULL,
	CONSTRAINT FK_Asistencia_TipoRacion FOREIGN KEY (IDTipoRacion)
	REFERENCES TipoRacion(IDTipoRacion)
	ON UPDATE NO ACTION
	ON DELETE NO ACTION,
	
	Raciones INT NOT NULL,
	Fecha DATE NOT NULL,
	Hora TIME NOT NULL
); 
GO


--TRIGGERS

--Trigger para encriptar la contraseña de los empleados 
CREATE OR ALTER TRIGGER TRG_Empleado_INSERT
ON Empleado
INSTEAD OF INSERT
AS
BEGIN
	DECLARE @IDRol AS INT;
	DECLARE @Nombre AS VARCHAR(30);
	DECLARE @ApellidoP AS VARCHAR(30);
	DECLARE @ApellidoM AS VARCHAR(30);
	DECLARE @FechaNacim AS INT;
	DECLARE @Correo AS VARCHAR(40);
	DECLARE @Contraseña AS VARCHAR(64);
	
	SELECT @IDRol = (SELECT IDRol FROM inserted);
	SELECT @Nombre = (SELECT Nombre FROM inserted);
	SELECT @ApellidoP = (SELECT ApellidoP FROM inserted);
	SELECT @ApellidoM = (SELECT ApellidoM FROM inserted);
	SELECT @FechaNacim = (SELECT FechaNacim FROM inserted);
	SELECT @Correo = (SELECT Correo FROM inserted);
	SELECT @Contraseña = (SELECT Contraseña FROM inserted);
	
	DECLARE @Sal AS VARCHAR(32);
	SELECT @Sal = CONVERT(VARCHAR(32), CRYPT_GEN_RANDOM(16), 2);

	DECLARE @ContraseñaHash AS VARCHAR(96);
	SELECT @ContraseñaHash = @Sal + CONVERT(VARCHAR(64), HASHBYTES('SHA2_256', @Sal + @Contraseña), 2);
	
	INSERT INTO Empleado
	VALUES (@IDRol, @Nombre, @ApellidoP, @ApellidoM, @FechaNacim, @Correo, @ContraseñaHash);
END;
GO

--Trigger para el actualizado de la contraseña de un empleado
CREATE OR ALTER TRIGGER TRG_Empleado_Contra
ON Empleado
AFTER UPDATE
AS
BEGIN
	SET NOCOUNT ON;
	DECLARE @Contraseña AS VARCHAR(64);
	SELECT @Contraseña = (SELECT Contraseña FROM inserted);

	DECLARE @Sal AS VARCHAR(32);
	SELECT @Sal = CONVERT(VARCHAR(32), CRYPT_GEN_RANDOM(16), 2);

	DECLARE @ContraseñaHash AS VARCHAR(96);
	SELECT @ContraseñaHash = @Sal + CONVERT(VARCHAR(64), HASHBYTES('SHA2_256', @Sal + @Contraseña), 2);
	
	UPDATE Empleado
	SET Contraseña = @ContraseñaHash
	FROM Empleado
	INNER JOIN inserted on Empleado.IDEmpleado = inserted.IDEmpleado
END;
GO


-- STORED PROCEDURES (SP)

-- SP para Insertar Datos
--Empleados (Supervisores)
CREATE OR ALTER PROCEDURE PROC_IEmpleadoS
@Nombre AS VARCHAR(30), @ApellidoP AS VARCHAR(30), @ApellidoM AS VARCHAR(30),
@FechaNacim AS INT, @Correo AS VARCHAR(40), @Contraseña AS VARCHAR(96)
AS
BEGIN
	INSERT INTO Empleado 
	VALUES (1, @Nombre, @ApellidoP, @ApellidoM, @FechaNacim, @Correo, @Contraseña)
END;
GO

--Empleados (Encargados)
CREATE OR ALTER PROCEDURE PROC_IEmpleadoE
@Nombre AS VARCHAR(30), @ApellidoP AS VARCHAR(30), @ApellidoM AS VARCHAR(30),
@FechaNacim AS INT, @Correo AS VARCHAR(40), @Contraseña AS VARCHAR(96)
AS
BEGIN
	INSERT INTO Empleado 
	VALUES (2, @Nombre, @ApellidoP, @ApellidoM, @FechaNacim, @Correo, @Contraseña)
END;
GO

--* @Estado --> VAR / INT
--* Duda implementación en Búsqueda --> IF
--Comedor
CREATE OR ALTER PROCEDURE PROC_IComedor
@CorreoEmpleado AS VARCHAR(40), @Estado AS INT, @Nombre AS VARCHAR(30),
@Capacidad AS INT, @Direccion AS VARCHAR(50), @Telefono AS VARCHAR(30)
AS
BEGIN
	DECLARE @EmpleadoBusq AS INT;
	SELECT @EmpleadoBusq = (SELECT IDEmpleado FROM Empleado WHERE 
	(Correo LIKE @CorreoEmpleado) AND (IDRol = 2));
	
	INSERT INTO Comedor 
	VALUES (@EmpleadoBusq, @Estado, @Nombre, @Capacidad, @Direccion, @Telefono)
END;
GO




/*
SP - ASISTENCIA
INSERT INTO Asistencia VALUES (1, (SELECT IDRegistro FROM Registro WHERE CURP LIKE 'BEHR%'), 1, 'Pagada', GETDATE());
INSERT INTO Asistencia VALUES (2, (SELECT IDRegistro FROM Registro WHERE CURP LIKE 'CLED%'), 3, 'Pagada', '2023-08-28 20:04:04');
*/


-- DML (Llenado de datos)

USE ComedorBD;
GO

-- Catálogo de Estados para los comedores
INSERT INTO EstadoComedor VALUES ('Abierto');
INSERT INTO EstadoComedor VALUES ('Cerrado');
GO

-- Catálogo de Tipos de Raciones a servir
INSERT INTO TipoRacion VALUES ('Pagada');
INSERT INTO TipoRacion VALUES ('Donada');
GO

-- Catálogo para el Sexo de un comensal
INSERT INTO Sexo VALUES ('Hombre');
INSERT INTO Sexo VALUES ('Mujer');
GO

-- Catálogo de Condiciones para los comensales 
INSERT INTO Condicion VALUES ('Menor a 5 años');
INSERT INTO Condicion VALUES ('Mayor a 65 años');
INSERT INTO Condicion VALUES ('Embarazada');
INSERT INTO Condicion VALUES ('Sordo');
INSERT INTO Condicion VALUES ('Ciego');
INSERT INTO Condicion VALUES ('Enfermedad Crónica');
GO

-- Catálogo para los Roles de un empleado
INSERT INTO Rol VALUES ('Supervisor');
INSERT INTO Rol VALUES ('Encargado');
GO

-- Empleados
INSERT INTO Empleado VALUES (1, 'Luis Adrián', 'Abarca', 'Gómez', 1985, 'abarca.gomez.luis@comedoresdif.com', 'Contra123');
INSERT INTO Empleado VALUES (1, 'Gerardo', 'Ríos', 'Mejía', 1987, 'gerry.rios@comedoresdif.com', 'ComedorST');
INSERT INTO Empleado VALUES (1, 'Benny', 'Sánchez', 'González', 1990, 'benny_gs@comedoresdif.com', 'ComedorCM');
INSERT INTO Empleado VALUES (1, 'Ángel', 'Márquez', 'Curiel', 1989, 'angeliu.marqcu@comedoresdif.com', 'ComedorMM');
INSERT INTO Empleado VALUES (1, 'José Ricardo', 'Moreno', 'Tahuilan', 1988, 'pepe.moreno@comedoresdif.com', 'ComedorCG');

INSERT INTO Empleado VALUES (2, 'Juan Carlos', 'Carro', 'Cruz', 1989, 'carro.cruz@comedoresdif.com', 'Password123');
INSERT INTO Empleado VALUES (2, 'Maria', 'Espinoza', 'Navarro', 1981, 'espinoza.navarro@comedoresdif.com', '1234567890');
INSERT INTO Empleado VALUES (2, 'Laura', 'Fernandez', 'Chavez', 1991, 'lfrnandez.chvz@comedoresdif.com', 'ComedorQI');
INSERT INTO Empleado VALUES (2, 'Armando', 'Torres', 'Índigo', 1985, 'torres.indigo@comedoresdif.com', 'ComedorCR');
GO

-- Comedores
INSERT INTO Comedor VALUES (6, 2, 'Cristo del Rodeo', 55, 'DireccionGenericaCR', '5561859871');
INSERT INTO Comedor VALUES (7, 1, 'Santiago Tlatelolco', 65, 'DireccionGenericaST', '556841203971');
INSERT INTO Comedor VALUES (8, 1, 'Cinco de Mayo', 85, 'DireccionGenericaCM', '555463178025');
INSERT INTO Comedor VALUES (9, 1, 'Monte María', 55, 'DireccionGenericaMM', '5568144872123');
GO

-- Menú
INSERT INTO Menu VALUES (1, 'Sopa de Caracol con Frijoles', 13.00, '2023-09-12');
INSERT INTO Menu VALUES (1, 'Nopales con Cilantro y Dos Tortillas', 13.00, '2023-09-13');
INSERT INTO Menu VALUES (2, 'Torta de papa con arroz', 13.00, '2023-09-12');
INSERT INTO Menu VALUES (2, 'Caldo de Pollo con Verduras y Agua', 13.00, '2023-09-13');
INSERT INTO Menu VALUES (3, 'Bisteces con hígado cebollado', 13.00, '2023-09-12');
INSERT INTO Menu VALUES (3, 'Torta de Jamón con Aguacate', 13.00, '2023-09-13');
INSERT INTO Menu VALUES (4, 'Licuado de Platano con arroz', 13.00, '2023-09-12');
INSERT INTO Menu VALUES (4, 'Albondigas con elote', 13.00, '2023-09-13');
GO

-- Comensales
INSERT INTO Comensal (Nombre, ApellidoP, ApellidoM, CURP, FechaNacim, IDSexo) VALUES ('Alfredo', 'Azamar', 'López', 'AALA031210HDFZPLA7', 2003, 1);
INSERT INTO Comensal (Nombre, ApellidoP, ApellidoM, CURP, FechaNacim, IDSexo) VALUES ('Marco', 'Cortes', 'Sandoval', 'MCCS125468OIFBDXT1', 1889, 1);
INSERT INTO Comensal VALUES (1, 'Daniel', 'Méndez', 'Ramos', 'DAMR235678QWDFGHU7', 2019, 1);
INSERT INTO Comensal VALUES (1, 'Sofia', 'Luna', 'Guerrero', 'SFLG120936SLDJCNE4', 2018, 2);
INSERT INTO Comensal VALUES (2, 'Jesús', 'Estrada', 'López', 'JUEL345092XWIJBSH8', 1951, 1);
INSERT INTO Comensal VALUES (3, 'Fernanda', 'González', 'Morales', 'FGSM234567PONDLAE2', 1995, 2);
INSERT INTO Comensal VALUES (3, 'Andrea', 'Cruz', 'Rivera', 'ANCR345389YCADHLP5', 1999, 2);
INSERT INTO Comensal VALUES (5, 'Valerio', 'Rojas', 'Castro', 'VLRC129237ABXMEIR9', 1981, 1);
INSERT INTO Comensal VALUES (6, 'Rebeca', 'Torres', 'Valle', 'ZRUB239845SLFURB3', 2001, 1);
GO

-- Asistencia
INSERT INTO Asistencia VALUES (1, 1, 1, 1, '2023-09-17', '17:25:32');
INSERT INTO Asistencia VALUES (1, 2, 1, 1, '2023-09-17', '13:01:22');
INSERT INTO Asistencia VALUES (1, 1, 2, 1, '2023-09-19', '14:15:55');
INSERT INTO Asistencia VALUES (2, 3, 1, 1, '2023-09-17', '14:53:42');
INSERT INTO Asistencia VALUES (2, 4, 1, 1, '2023-09-17', '13:14:32');
INSERT INTO Asistencia VALUES (2, 4, 2, 1, '2023-09-20', '15:23:12');
INSERT INTO Asistencia VALUES (3, 5, 1, 1, '2023-09-17', '14:12:21');
INSERT INTO Asistencia VALUES (3, 6, 1, 1, '2023-09-17', '15:42:42');
INSERT INTO Asistencia VALUES (3, 5, 2, 1, '2023-09-18', '12:13:52');
INSERT INTO Asistencia VALUES (4, 7, 1, 1, '2023-09-17', '15:12:03');
INSERT INTO Asistencia VALUES (4, 8, 1, 1, '2023-09-17', '15:32:12');
INSERT INTO Asistencia VALUES (4, 8, 2, 1, '2023-09-21', '16:33:32');
GO


-- PRUEBAS 

USE ComedorBD;
GO

-- SPs
EXECUTE PROC_IEmpleadoS 'Luis Adrián', 'Abarca', 'Gómez', 1985, 'abarca.gomez.luis@comedoresdif.com', 'Contra123';
GO

EXECUTE PROC_IComedor 'carro.cruz@comedoresdif.com', 1, 'Santiago Tlatelolco', 65, 'DireccionGenericaST', '556841203971';
GO

SELECT *
FROM Empleado

SELECT *
FROM EstadoComedor

SELECT *
FROM Comedor


-- Posibles queries
SELECT SUM(Raciones) * 13 AS Ganancias
FROM Asistencia
WHERE IDComedor = 1

SELECT COUNT(IDAsistencia) AS 'Racione servidas pagadas'
FROM Asistencia
WHERE IDComedor = 1 AND TipoRacion LIKE 'Pagada'

