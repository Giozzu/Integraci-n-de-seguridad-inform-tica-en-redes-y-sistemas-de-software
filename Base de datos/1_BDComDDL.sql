-- ---------------------------------------------------------
-- Nombre del Script: 1_BDComDDL.sql
-- Propósito: Creación de la estructura de la Base de Datos
--			  del proyecto Plato DIF-F.
-- Fecha de Creación: 2023-09-16
-- Autor: Alfredo Azamar López
-- ---------------------------------------------------------

Use master;
GO

IF EXISTS (SELECT 1 FROM sys.databases WHERE [name] = 'ComedorBD')
BEGIN
	ALTER DATABASE ComedorBD SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
	DROP DATABASE ComedorBD;
END;

CREATE DATABASE ComedorBD;
GO


USE ComedorBD;
GO

DROP TABLE IF EXISTS EstadoComedor;
DROP TABLE IF EXISTS TipoRacion;
DROP TABLE IF EXISTS Sexo;
DROP TABLE IF EXISTS Condicion;
DROP TABLE IF EXISTS Rol;
DROP TABLE IF EXISTS Pregunta;
DROP TABLE IF EXISTS Empleado;
DROP TABLE IF EXISTS Comedor;
DROP TABLE IF EXISTS Menu;
DROP TABLE IF EXISTS Incidencia;
DROP TABLE IF EXISTS Encuesta;
DROP TABLE IF EXISTS Comensal;
DROP TABLE IF EXISTS CondicionComensal;
DROP TABLE IF EXISTS Asistencia;


-- ---------------------------------------------------------
-- Nombre de la Tabla: EstadoComedor
-- Propósito: Almacena información relacionada al estado
--		      de apertura de un comedor.
-- ---------------------------------------------------------
CREATE TABLE EstadoComedor (
	IDEstadoComedor INT NOT NULL PRIMARY KEY IDENTITY(1,1),
	Nombre VARCHAR(30) NOT NULL UNIQUE
);
GO


-- ---------------------------------------------------------
-- Nombre de la Tabla: TipoRacion
-- Propósito: Almacena información relacionada al tipo de 
--		      ración que puede adquirir un comensal
-- ---------------------------------------------------------
CREATE TABLE TipoRacion (
	IDTipoRacion INT NOT NULL PRIMARY KEY IDENTITY(1,1),
	Tipo VARCHAR(20) NOT NULL UNIQUE
);
GO


-- ---------------------------------------------------------
-- Nombre de la Tabla: Sexo
-- Propósito: Almacena información sobre el sexo de una 
--			  persona 
-- ---------------------------------------------------------
CREATE TABLE Sexo (
	IDSexo INT NOT NULL PRIMARY KEY IDENTITY(1,1),
	Descripcion VARCHAR(30) NOT NULL UNIQUE
);
GO


-- ---------------------------------------------------------
-- Nombre de la Tabla: Condicion
-- Propósito: Almacena información sobre las situaciones 
--			  vulnerables existentes
-- ---------------------------------------------------------
CREATE TABLE Condicion (
	IDCondicion INT NOT NULL PRIMARY KEY IDENTITY(1,1),
	Nombre VARCHAR(30) NOT NULL UNIQUE
);
GO


-- ---------------------------------------------------------
-- Nombre de la Tabla: Pregunta
-- Propósito: Almacena información sobre las preguntas de 
--			  las encuestas
-- ---------------------------------------------------------
CREATE TABLE Pregunta (
	IDPregunta INT NOT NULL PRIMARY KEY IDENTITY(1,1),
	Pregunta VARCHAR(60) NOT NULL
);
GO


-- ---------------------------------------------------------
-- Nombre de la Tabla: Rol
-- Propósito: Almacena información relacionada al rol de un 
--			  empleado dentro del proyecto “Comedores 
--			  Comunitarios” del DIF
-- ---------------------------------------------------------
CREATE TABLE Rol (
	IDRol INT NOT NULL PRIMARY KEY IDENTITY(1,1),
	Nombre VARCHAR(30) NOT NULL UNIQUE
);
GO


-- ---------------------------------------------------------
-- Nombre de la Tabla: Empleado
-- Propósito: Almacena información relacionada a los empleados
-- ---------------------------------------------------------
CREATE TABLE Empleado (
	IDEmpleado INT NOT NULL PRIMARY KEY IDENTITY(1,1),
	IDRol INT NOT NULL,
	CONSTRAINT FK_Empleado_Rol FOREIGN KEY (IDRol)
	REFERENCES Rol(IDRol)
	ON UPDATE NO ACTION
	ON DELETE NO ACTION,

	Nombre VARCHAR(30) NOT NULL,
	ApellidoP VARCHAR(30) NOT NULL,
	ApellidoM VARCHAR(30) NOT NULL,
	FechaNacim INT NOT NULL,
	IDSexo INT NULL,
	CONSTRAINT FK_Empleado_Sexo FOREIGN KEY (IDSexo)
	REFERENCES Sexo(IDSexo)
	ON UPDATE NO ACTION
	ON DELETE NO ACTION,

	Correo VARCHAR(40) NOT NULL,
	NombreUsuario VARCHAR(40) NOT NULL UNIQUE,
	Contraseña VARCHAR(96) NOT NULL UNIQUE
);
GO


-- ---------------------------------------------------------
-- Nombre de la Tabla: Comedor
-- Propósito: Almacena información relacionada a los 
--			  comedores comunitarios
-- ---------------------------------------------------------
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

	Nombre VARCHAR(30) NOT NULL UNIQUE,
	Capacidad INT NOT NULL,
	Direccion VARCHAR(70) NOT NULL,
	Telefono VARCHAR(30) NOT NULL,
	
);
GO

-- ---------------------------------------------------------
-- Nombre de la Tabla: Menu
-- Propósito: Almacena información relacionada al menú de 
--			  comida servida dentro de los comedores
-- ---------------------------------------------------------
CREATE TABLE Menu (
	IDMenu INT NOT NULL PRIMARY KEY IDENTITY(1,1),
	IDComedor INT NOT NULL, 
	CONSTRAINT FK_Menu_Comedor FOREIGN KEY (IDComedor)
	REFERENCES Comedor(IDComedor)
	ON UPDATE NO ACTION
	ON DELETE NO ACTION,

	SopaArroz VARCHAR(50) NOT NULL,
	PlatoFuerte VARCHAR(50) NOT NULL,
	PanTortilla VARCHAR(50) NOT NULL,
	AguaDelDia VARCHAR(30) NOT NULL,
	FrijolesSalsa VARCHAR(50) NOT NULL,
	Precio DECIMAL(10,2) NOT NULL,
	Fecha DATE NOT NULL
); 
GO


-- ---------------------------------------------------------
-- Nombre de la Tabla: Incidencia
-- Propósito: Almacena información relacionada a las 
--			  incidencias de un comedor
-- ---------------------------------------------------------
CREATE TABLE Incidencia (
	IDIncidencia INT NOT NULL PRIMARY KEY IDENTITY (1,1),
	IDComedor INT NOT NULL, 
	CONSTRAINT FK_Incidencia_Comedor FOREIGN KEY (IDComedor)
	REFERENCES Comedor(IDComedor)
	ON UPDATE NO ACTION
	ON DELETE NO ACTION, 
	
	Tipo VARCHAR(30) NOT NULL,
	Descripcion VARCHAR(60) NULL,
	Fecha DATE NOT NULL
);
GO

-- ---------------------------------------------------------
-- Nombre de la Tabla: Encuesta
-- Propósito: Almacena información relacionada a las encuestas
-- ---------------------------------------------------------
CREATE TABLE Encuesta (
	IDEncuesta INT NOT NULL PRIMARY KEY IDENTITY (1,1),
	IDComedor INT NOT NULL, 
	CONSTRAINT FK_Encuesta_Comedor FOREIGN KEY (IDComedor)
	REFERENCES Comedor(IDComedor)
	ON UPDATE NO ACTION
	ON DELETE NO ACTION, 

	IDPregunta INT NOT NULL, 
	CONSTRAINT FK_Encuesta_Pregunta FOREIGN KEY (IDPregunta)
	REFERENCES Pregunta(IDPregunta)
	ON UPDATE NO ACTION
	ON DELETE NO ACTION, 
	
	Comentarios VARCHAR(80) NULL,
	Calificacion INT NOT NULL,
	Fecha DATE
);
GO

-- ---------------------------------------------------------
-- Nombre de la Tabla: Comensal
-- Propósito: Almacena información relacionada a los comensales
-- ---------------------------------------------------------
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

-- ---------------------------------------------------------
-- Nombre de la Tabla: CondicionComensal
-- Propósito: Almacena información sobre las situaciones 
--			  vulnerables de un comensal
-- ---------------------------------------------------------
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


-- ---------------------------------------------------------
-- Nombre de la Tabla: Asistencia
-- Propósito: Almacena información sobre el registro de asistencia
-- ---------------------------------------------------------
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
	Fecha DATE NOT NULL
); 
GO
