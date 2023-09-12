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
DROP TABLE IF EXISTS Condicion;
DROP TABLE IF EXISTS Supervisor;
DROP TABLE IF EXISTS Encargado;
DROP TABLE IF EXISTS Comedor;
DROP TABLE IF EXISTS Menu;
DROP TABLE IF EXISTS CorteDiario;
DROP TABLE IF EXISTS Comensal;
DROP TABLE IF EXISTS Asistencia;


-- Catálogo de Estados que tiene un comedor
CREATE TABLE EstadoComedor (
	IDEstadoComedor INT NOT NULL PRIMARY KEY IDENTITY(1,1),
	Nombre VARCHAR(30) NOT NULL UNIQUE
);
GO

-- Catálogo de Condiciones para los comensales 
CREATE TABLE Condicion (
	IDCondicion INT NOT NULL PRIMARY KEY IDENTITY(1,1),
	Nombre VARCHAR(30) NOT NULL UNIQUE
);
GO

-- Catálogo de Supervisores 
CREATE TABLE Supervisor (
	IDSupervisor INT NOT NULL PRIMARY KEY IDENTITY(1,1),
	Nombre VARCHAR(30) NOT NULL,
	ApellidoP VARCHAR(30) NOT NULL,
	ApellidoM VARCHAR(30) NOT NULL,
	FechaNacim INT NOT NULL,
	Correo VARCHAR(40) NOT NULL UNIQUE,
	Contraseña VARCHAR(96) NOT NULL UNIQUE
);
GO

-- Catálogo de Encargados
CREATE TABLE Encargado(
	IDEncargado INT NOT NULL PRIMARY KEY IDENTITY(1,1),
	IDSupervisor INT NOT NULL,
	CONSTRAINT FK_Encargado_Supervisor FOREIGN KEY (IDSupervisor)
	REFERENCES Supervisor(IDSupervisor)
	ON UPDATE NO ACTION
	ON DELETE NO ACTION,

	Nombre VARCHAR(30) NOT NULL,
	ApellidoP VARCHAR(30) NOT NULL,
	ApellidoM VARCHAR(30) NOT NULL,
	FechaNacim INT NOT NULL,
	CURP VARCHAR(18) NOT NULL UNIQUE,
	Contraseña VARCHAR(96) NOT NULL UNIQUE
);
GO

-- Catálogo de Comedores 
CREATE TABLE Comedor (
	IDComedor INT NOT NULL PRIMARY KEY IDENTITY(1,1),
	IDEncargado INT NOT NULL,
	CONSTRAINT FK_Comedor_Encargado FOREIGN KEY (IDEncargado)
	REFERENCES Encargado(IDEncargado)
	ON UPDATE NO ACTION
	ON DELETE NO ACTION,

	Nombre VARCHAR(30) NOT NULL,
	Capacidad INT NOT NULL,
	Direccion VARCHAR(50) NOT NULL,
	Telefono VARCHAR(30) NOT NULL,
	Estatus BIT NOT NULL
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
	Precio INT
); 
GO

CREATE TABLE CorteDiario (
	IDCorteDiario INT NOT NULL PRIMARY KEY IDENTITY(1,1),
	IDComedor INT NOT NULL, 
	CONSTRAINT FK_CorteDiario_Comedor FOREIGN KEY (IDComedor)
	REFERENCES Comedor(IDComedor)
	ON UPDATE NO ACTION
	ON DELETE NO ACTION,

	Producto VARCHAR(30) NOT NULL,
	Cantidad INT NOT NULL,
	PrecioUnitario DECIMAL(10,2) NOT NULL,
	Fecha DATE NOT NULL
);
GO

-- Tabla para el Registro
CREATE TABLE Comensal (
	IDComensal INT NOT NULL PRIMARY KEY IDENTITY(1,1),
	IDCondicion INT NOT NULL,
	CONSTRAINT FK_Comensal_Condicion FOREIGN KEY (IDCondicion)
	REFERENCES Condicion(IDCondicion)
	ON UPDATE NO ACTION
	ON DELETE NO ACTION,

	Nombre VARCHAR(30) NOT NULL,
	ApellidoP VARCHAR(30) NOT NULL,
	ApellidoM VARCHAR(30) NOT NULL,
	CURP VARCHAR(18) NOT NULL UNIQUE,
	FechaNacim INT NOT NULL,
	Sexo VARCHAR(20) NOT NULL,
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

	Raciones INT NOT NULL,
	TipoRacion VARCHAR(10) NOT NULL,
	Fecha DATE NOT NULL,
	Hora TIME NOT NULL
); 
GO



--Triggers

/*
-Para encriptar las contraseñas de los Encargados y Supervisores (INSERT)
-Para actualizado de las contraseñas de los Encargados y Supervisores (UPDATE)


*/



-- DML (Llenado de datos)

USE ComedorBD;
GO

-- Catálogo de Estados para los comedores
INSERT INTO EstadoComedor VALUES ('Abierto');
INSERT INTO EstadoComedor VALUES ('Cerrado');
GO

-- Catálogo de Condiciones para los comensales 
INSERT INTO Condicion VALUES ('Menor a 5 años');
INSERT INTO Condicion VALUES ('Mayor a 65 años');
INSERT INTO Condicion VALUES ('Embarazada');
INSERT INTO Condicion VALUES ('Sordo');
INSERT INTO Condicion VALUES ('Ciego');
INSERT INTO Condicion VALUES ('Discapacitado');
GO

-- Catálogo de Supervisores
INSERT INTO Supervisor VALUES ('Juan Carlos', 'Carro', 'Cruz', 1989, 'carro.cruz@comedoresdif.com', 'Password123');
INSERT INTO Supervisor VALUES ('Luis Adrián', 'Abarca', 'Gómez', 1985, 'abarca.gomez.luis@comedoresdif.com', 'Contra123');
INSERT INTO Supervisor VALUES ('Maria', 'Espinoza', 'Navarro', 1981, 'espinoza.navarro@comedoresdif.com', '1234567890');
GO

-- Catálogo de Encargados
INSERT INTO Encargado VALUES (1, 'Laura', 'Fernandez', 'Chavez', 1991, 'MLRE782301LODENQ3', 'ComedorQI');
INSERT INTO Encargado VALUES (1, 'Armando', 'Torres', 'Índigo', 1985, 'INTR127840DFNBLZ9', 'ComedorCR');
INSERT INTO Encargado VALUES (2, 'Gerardo', 'Ríos', 'Mejía', 1987, 'CLED063842DIWMCL1', 'ComedorST');
INSERT INTO Encargado VALUES (2, 'Benny', 'Sánchez', 'González', 1990, 'BEHR369837HJDLWR5', 'ComedorCM');
INSERT INTO Encargado VALUES (3, 'Ángel', 'Márquez', 'Curiel', 1989, 'BEHR369837HJDLWR5', 'ComedorMM');
INSERT INTO Encargado VALUES (3, 'José Ricardo', 'Moreno', 'Tahuilan', 1988, 'LMAD293405FEKOXW4', 'ComedorCG');

-- Comedores
INSERT INTO Comedor VALUES (3, 'Santiago Tlatelolco', 65, );



SELECT *
FROM Comedor





--INSERT INTO Comensal VALUES (1, 'Alfredo', 'Azamar', 'López', 'AALA031210HDFZPLA7', 2003, 'Hombre', 'Stinky');

/*
INSERT INTO Registro VALUES (1, 'Benny', 'Sánchez', 'González', 'BEHR369837HJDLWR5', 2003, 'Hombre', 'Vigo');
INSERT INTO Registro VALUES (2, 'Gerardo', 'Ríos', 'Mejía', 'CLED063842DIWMCLS1', 2002, 'Hombre', 'Aseñorado');
INSERT INTO Registro VALUES (3, 'Ángel', 'Márquez', 'Curiel', 'AWIC129846LDMSIEC9', 2004, 'Hombre', 'Torta?');
INSERT INTO Registro VALUES (3, 'José Ricardo', 'Moreno', 'Tahuilan', 'LMAD293405FEKOXW4', 2000, 'Hombre', 'Nerd');
INSERT INTO Registro VALUES (4, 'Daniela', 'Reyes', 'Perez', 'WERY0937462DFLMAW8', 2001, 'Mujer', 'IDK');
INSERT INTO Registro VALUES (5, 'Rebeca', 'Torres', 'Valle', 'ZRUB239845SLFURB3', 2001, 'Mujer', 'Normal');

INSERT INTO Asistencia VALUES (1, (SELECT IDRegistro FROM Registro WHERE CURP LIKE 'BEHR%'), 1, 'Pagada', GETDATE());
INSERT INTO Asistencia VALUES (2, (SELECT IDRegistro FROM Registro WHERE CURP LIKE 'CLED%'), 3, 'Pagada', '2023-08-28 20:04:04');


*/


USE ComedorBD;
GO

SELECT *
FROM Comedor

SELECT *
FROM Comensal

SELECT *
FROM Asistencia


-- Posibles queries
SELECT SUM(Raciones) * 13 AS Ganancias
FROM Asistencia
WHERE IDComedor = 1

SELECT COUNT(IDAsistencia) AS 'Racione servidas pagadas'
FROM Asistencia
WHERE IDComedor = 1 AND TipoRacion LIKE 'Pagada'

