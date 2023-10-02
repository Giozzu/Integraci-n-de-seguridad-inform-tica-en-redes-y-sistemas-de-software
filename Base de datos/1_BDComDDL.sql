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
DROP TABLE IF EXISTS Incidencias;
DROP TABLE IF EXISTS Comensal;
DROP TABLE IF EXISTS CondicionComensal;
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
	Tipo VARCHAR(20) NOT NULL UNIQUE
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
	NombreUsario VARCHAR(40) NOT NULL UNIQUE,
	Contraseña VARCHAR(96) NOT NULL UNIQUE
);
GO

-- Catálogo de Comedores 
CREATE TABLE Comedor (
	IDComedor INT NOT NULL PRIMARY KEY IDENTITY(1,1),
	IDEmpleado INT NULL,
	CONSTRAINT FK_Comedor_Empleadoo FOREIGN KEY (IDEmpleado)
	REFERENCES Empleado(IDEmpleado)
	ON UPDATE NO ACTION
	ON DELETE NO ACTION,

	IDEstado INT NOT NULL,
	CONSTRAINT FK_Comedor_EstadoComedor FOREIGN KEY (IDEstado)
	REFERENCES EstadoComedor(IDEstadoComedor)
	ON UPDATE NO ACTION
	ON DELETE NO ACTION,

	Nombre VARCHAR(30) NOT NULL UNIQUE,
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

	SopaArroz VARCHAR(50) NULL,
	PlatoFuerte VARCHAR(50) NULL,
	PanToritilla VARCHAR(50) NULL,
	AguaDelDia VARCHAR(30) NULL,
	FrijolesSalsa VARCHAR(50) NULL,
	Precio DECIMAL(10,2) NOT NULL,
	Fecha DATE NOT NULL
); 
GO

--Tabla para levantar una Incidencia sobre el comedor
CREATE TABLE Incidencias (
	IDIncidencia INT NOT NULL PRIMARY KEY IDENTITY (1,1),
	IDComedor INT NOT NULL, 
	CONSTRAINT FK_Incidencias_Comedor FOREIGN KEY (IDComedor)
	REFERENCES Comedor(IDComedor)
	ON UPDATE NO ACTION
	ON DELETE NO ACTION, 
	
	Tipo VARCHAR(30) NOT NULL,
	Descripcion VARCHAR(60) NOT NULL,
	Fecha DATE NOT NULL,
	Hora TIME NOT NULL
);
GO


-- Tabla para el registro de los Comensales
CREATE TABLE Comensal (
	IDComensal INT NOT NULL PRIMARY KEY IDENTITY(1,1),

	Nombre VARCHAR(30) NULL,
	ApellidoP VARCHAR(30) NULL,
	ApellidoM VARCHAR(30) NULL,
	CURP VARCHAR(18) NOT NULL UNIQUE,
	FechaNacim INT NULL,
	IDSexo INT NULL,
	CONSTRAINT FK_Comensal_Sexo FOREIGN KEY (IDSexo)
	REFERENCES Sexo(IDSexo)
	ON UPDATE NO ACTION
	ON DELETE NO ACTION,

	Token INT NOT NULL UNIQUE,
);
GO

-- Tabla para el registro de más de una Condición -> comensal
CREATE TABLE CondicionComensal (
	IDComensal INT NOT NULL,
	IDCondicion INT NOT NULL,
	PRIMARY KEY (IDComensal, IDCondicion),
	
	CONSTRAINT FK_CondicionComensal_Comensal FOREIGN KEY (IDComensal)
	REFERENCES Comensal(IDComensal)
	ON UPDATE NO ACTION
	ON DELETE NO ACTION,

	CONSTRAINT FK_CondicionComensal_Condicion FOREIGN KEY (IDCondicion)
	REFERENCES Condicion(IDCondicion)
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