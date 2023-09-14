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
DROP TABLE IF EXISTS Sexo;
DROP TABLE IF EXISTS Condicion;
DROP TABLE IF EXISTS Permiso;
DROP TABLE IF EXISTS Empleado;
DROP TABLE IF EXISTS Comedor;
DROP TABLE IF EXISTS Menu;
DROP TABLE IF EXISTS Comensal;
DROP TABLE IF EXISTS Asistencia;

--*
-- Catálogo de Estados que tiene un comedor
CREATE TABLE EstadoComedor (
	IDEstadoComedor INT NOT NULL PRIMARY KEY IDENTITY(1,1),
	Nombre VARCHAR(30) NOT NULL UNIQUE,
	Incidencia VARCHAR(50) NULL,
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
CREATE TABLE Permiso (
	IDPermiso INT NOT NULL PRIMARY KEY IDENTITY(1,1),
	Nombre VARCHAR(30) NOT NULL UNIQUE
);
GO

-- Catálogo de Empleados
CREATE TABLE Empleado (
	IDEmpleado INT NOT NULL PRIMARY KEY IDENTITY(1,1),
	IDPermiso INT NOT NULL,
	CONSTRAINT FK_Empleado_Privilegio FOREIGN KEY (IDPermiso)
	REFERENCES Permiso(IDPermiso)
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

-- Historial de Precios
INSERT INTO Precio VALUES (13.00, '2023-09-12');
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
INSERT INTO Encargado VALUES (3, 'Ángel', 'Márquez', 'Curiel', 1989, 'AMCA361487QWCVJK1', 'ComedorMM');
INSERT INTO Encargado VALUES (3, 'José Ricardo', 'Moreno', 'Tahuilan', 1988, 'LMAD293405FEKOXW4', 'ComedorCG');
GO

-- Comedores
INSERT INTO Comedor VALUES (2, 2, 'Cristo del Rodeo', 55, 'DireccionGenericaCR', '5561859871');
INSERT INTO Comedor VALUES (3, 1, 'Santiago Tlatelolco', 65, 'DireccionGenericaST', '556841203971');
INSERT INTO Comedor VALUES (4, 1, 'Cinco de Mayo', 85, 'DireccionGenericaCM', '555463178025');
INSERT INTO Comedor VALUES (5, 1, 'Monte María', 55, 'DireccionGenericaMM', '5568144872123');
INSERT INTO Comedor VALUES (6, 1, 'Canto García', 95, 'DireccionGenericaCG', '553618715171');
GO

-- Menú
INSERT INTO Menu VALUES (1, 1, 'Sopa de Caracol con Frijoles', '2023-09-12');
INSERT INTO Menu VALUES (1, 1, 'Nopales con Cilantro y Dos Tortillas', '2023-09-13');
INSERT INTO Menu VALUES (2, 1, 'Torta de papa con arroz', '2023-09-12');
INSERT INTO Menu VALUES (2, 1, 'Caldo de Pollo con Verduras y Agua', '2023-09-13');
INSERT INTO Menu VALUES (3, 1, 'Bisteces con hígado cebollado', '2023-09-12');
INSERT INTO Menu VALUES (3, 1, 'Torta de Jamón con Aguacate', '2023-09-13');
INSERT INTO Menu VALUES (4, 1, 'Licuado de Platano con arroz', '2023-09-12');

-- Comensales
INSERT INTO Comensal (Nombre, ApellidoP, ApellidoM, CURP, FechaNacim, Sexo) VALUES ('Alfredo', 'Azamar', 'López', 'AALA031210HDFZPLA7', 2003, 'Hombre');
INSERT INTO Comensal (Nombre, ApellidoP, ApellidoM, CURP, FechaNacim, Sexo) VALUES ('Marco', 'Cortes', 'Sandoval', 'MCCS125468OIFBDXT1', 1889, 'Hombre');


DROP TABLE IF EXISTS Asistencia;

SELECT *
FROM Comensal





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

