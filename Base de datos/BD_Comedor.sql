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
DROP TABLE IF EXISTS Pregunta;
DROP TABLE IF EXISTS Empleado;
DROP TABLE IF EXISTS Comedor;
DROP TABLE IF EXISTS Menu;
DROP TABLE IF EXISTS Incidencias;
DROP TABLE IF EXISTS Encuesta;
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

-- Catálogo de las Preguntas para la encuesta 
CREATE TABLE Pregunta (
	IDPregunta INT NOT NULL PRIMARY KEY IDENTITY(1,1),
	Pregunta VARCHAR(60) NOT NULL
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
	IDSexo INT NULL,
	CONSTRAINT FK_Empleado_Sexo FOREIGN KEY (IDSexo)
	REFERENCES Sexo(IDSexo)
	ON UPDATE NO ACTION
	ON DELETE NO ACTION,

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

	SopaArroz VARCHAR(50) NOT NULL,
	PlatoFuerte VARCHAR(50) NOT NULL,
	PanToritilla VARCHAR(50) NOT NULL,
	AguaDelDia VARCHAR(30) NOT NULL,
	FrijolesSalsa VARCHAR(50) NOT NULL,
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
	Descripcion VARCHAR(60) NULL,
	Fecha DATE NOT NULL
);
GO

--Tabla de las encuestas
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
	Fecha DATE NOT NULL
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
	DECLARE @IDSexo AS INT;
	DECLARE @Correo AS VARCHAR(40);
	DECLARE @NombreUsario AS VARCHAR(40);
	DECLARE @Contraseña AS VARCHAR(64);
	
	SELECT @IDRol = (SELECT IDRol FROM inserted);
	SELECT @Nombre = (SELECT Nombre FROM inserted);
	SELECT @ApellidoP = (SELECT ApellidoP FROM inserted);
	SELECT @ApellidoM = (SELECT ApellidoM FROM inserted);
	SELECT @FechaNacim = (SELECT FechaNacim FROM inserted);
	SELECT @Correo = (SELECT Correo FROM inserted)
	SELECT @IDSexo = (SELECT IDSexo FROM inserted);
	SELECT @NombreUsario = (SELECT NombreUsario FROM inserted);
	SELECT @Contraseña = (SELECT Contraseña FROM inserted);
	
	DECLARE @Sal AS VARCHAR(32);
	SELECT @Sal = CONVERT(VARCHAR(32), CRYPT_GEN_RANDOM(16), 2);

	DECLARE @ContraseñaHash AS VARCHAR(96);
	SELECT @ContraseñaHash = @Sal + CONVERT(VARCHAR(64), HASHBYTES('SHA2_256', @Sal + @Contraseña), 2);
	
	INSERT INTO Empleado
	VALUES (@IDRol, @Nombre, @ApellidoP, @ApellidoM, @FechaNacim, @IDSexo, @Correo, @NombreUsario, @ContraseñaHash);
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
-- WEB --
--Empleados (Supervisores)
CREATE OR ALTER PROCEDURE PROC_IEmpleadoS
@Nombre AS VARCHAR(30), @ApellidoP AS VARCHAR(30), @ApellidoM AS VARCHAR(30),
@FechaNacim AS INT, @DescSexo AS VARCHAR(30), @Correo AS VARCHAR(40), 
@NombreUsario AS VARCHAR(40), @Contraseña AS VARCHAR(96)
AS
BEGIN
	DECLARE @SexoBusq AS INT;

	SELECT @SexoBusq = (SELECT IDSexo FROM Sexo WHERE Descripcion LIKE @DescSexo) 
	
	INSERT INTO Empleado 
	VALUES (1, @Nombre, @ApellidoP, @ApellidoM, @FechaNacim, @SexoBusq, @Correo, @NombreUsario, @Contraseña)
END;
GO

--Empleados (Encargados)
CREATE OR ALTER PROCEDURE PROC_IEmpleadoE
@Nombre AS VARCHAR(30), @ApellidoP AS VARCHAR(30), @ApellidoM AS VARCHAR(30),
@FechaNacim AS INT, @DescSexo AS VARCHAR(30), @Correo AS VARCHAR(40), 
@NombreUsario AS VARCHAR(40), @Contraseña AS VARCHAR(96)
AS
BEGIN
	DECLARE @SexoBusq AS INT;

	SELECT @SexoBusq = (SELECT IDSexo FROM Sexo WHERE Descripcion LIKE @DescSexo)

	INSERT INTO Empleado 
	VALUES (2, @Nombre, @ApellidoP, @ApellidoM, @FechaNacim, @SexoBusq, @Correo, @NombreUsario, @Contraseña)
END;
GO

--Comedor
CREATE OR ALTER PROCEDURE PROC_IComedor
@CorreoEmpleado AS VARCHAR(40), @NombreEstadoC AS VARCHAR(30), @Nombre AS VARCHAR(30),
@Capacidad AS INT, @Direccion AS VARCHAR(50), @Telefono AS VARCHAR(30)
AS
BEGIN
	DECLARE @EmpleadoBusq AS INT;
	DECLARE @EstadoComBusq AS INT;

	SELECT @EmpleadoBusq = (SELECT IDEmpleado FROM Empleado WHERE 
	(Correo LIKE @CorreoEmpleado) AND (IDRol = 2));
	SELECT @EstadoComBusq = (SELECT IDEstadoComedor FROM EstadoComedor WHERE Nombre LIKE @NombreEstadoC) 

	INSERT INTO Comedor 
	VALUES (@EmpleadoBusq, @EstadoComBusq, @Nombre, @Capacidad, @Direccion, @Telefono)
END;
GO

-- APP VOL/ENC --
--Menú
CREATE OR ALTER PROCEDURE PROC_IMenu
@NombreComedor AS VARCHAR(30), @SopaArroz AS VARCHAR(50), @PlatoFuerte AS VARCHAR(50),
@PanToritilla AS VARCHAR(50), @AguaDelDia AS VARCHAR(30), @FrijolesSalsa AS VARCHAR(50),
@Fecha AS DATE
AS
BEGIN
	DECLARE @ComedorBusq AS INT;

	SELECT @ComedorBusq = (SELECT IDComedor FROM Comedor WHERE Nombre LIKE @NombreComedor) 
	
	INSERT INTO Menu 
	VALUES (@ComedorBusq, @SopaArroz, @PlatoFuerte, @PanToritilla, @AguaDelDia, @FrijolesSalsa, 13.00, @Fecha)
END;
GO

--Incidencias
CREATE OR ALTER PROCEDURE PROC_IIncidencias
@NombreComedor AS VARCHAR(30), @Tipo AS VARCHAR(30), 
@Descripcion AS VARCHAR(60), @Fecha AS DATE
AS
BEGIN	
	DECLARE @ComedorBusq AS INT;

	SELECT @ComedorBusq = (SELECT IDComedor FROM Comedor WHERE Nombre LIKE @NombreComedor) 
	
	INSERT INTO Incidencias 
	VALUES (@ComedorBusq, @Tipo, @Descripcion, @Fecha)
END;
GO

--Comensal
CREATE OR ALTER PROCEDURE PROC_IComensal
@Nombre AS VARCHAR(30), @ApellidoP AS VARCHAR(30), @ApellidoM AS VARCHAR(30),
@CURP AS VARCHAR(18), @FechaNacim AS INT, @DescSexo AS VARCHAR(30),
@Token AS INT
AS
BEGIN
	DECLARE @SexoBusq AS INT;

	SELECT @SexoBusq = (SELECT IDSexo FROM Sexo WHERE Descripcion LIKE @DescSexo) 
	
	INSERT INTO Comensal 
	VALUES (@Nombre, @ApellidoP, @ApellidoM, @CURP, @FechaNacim, @SexoBusq, @Token)
END;
GO

--Condición del Comensal
CREATE OR ALTER PROCEDURE PROC_ICondCom
@ComensalCURP AS VARCHAR(18), @NombreCond AS VARCHAR(30)
AS
BEGIN
	DECLARE @ComensalBusq AS INT;
	DECLARE @CondicionBusq AS INT;

	SELECT @ComensalBusq = (SELECT IDComensal FROM Comensal WHERE CURP LIKE @ComensalCURP)
	SELECT @CondicionBusq = (SELECT IDCondicion FROM Condicion WHERE Nombre LIKE @NombreCond) 	

	INSERT INTO CondicionComensal 
	VALUES (@ComensalBusq, @CondicionBusq)
END;
GO

--Asistencia por CURP
CREATE OR ALTER PROCEDURE PROC_IAsistenciaC
@NombreComedor AS VARCHAR(30), @TipoRacion AS VARCHAR(20),
@Raciones AS INT, @Fecha AS DATE, @ComensalCURP AS VARCHAR(18)
AS
BEGIN
	DECLARE @ComedorBusq AS INT;
	DECLARE @ComensalBusq AS INT;
	DECLARE @TipoRacionBusq AS INT;

	SELECT @ComedorBusq = (SELECT IDComedor FROM Comedor WHERE Nombre LIKE @NombreComedor) 
	SELECT @ComensalBusq = (SELECT IDComensal FROM Comensal WHERE CURP LIKE @ComensalCURP)
	SELECT @TipoRacionBusq = (SELECT IDTipoRacion FROM TipoRacion WHERE Tipo LIKE @TipoRacion)
	
	INSERT INTO Asistencia 
	VALUES (@ComedorBusq, @ComensalBusq, @TipoRacionBusq, @Raciones, @Fecha)
END;
GO

--Asistencia por Token
CREATE OR ALTER PROCEDURE PROC_IAsistenciaT
@NombreComedor AS VARCHAR(30), @TipoRacion AS VARCHAR(20),
@Raciones AS INT, @Fecha AS DATE, @Token AS INT
AS
BEGIN
	DECLARE @ComedorBusq AS INT;
	DECLARE @ComensalBusq AS INT;
	DECLARE @TipoRacionBusq AS INT;

	SELECT @ComedorBusq = (SELECT IDComedor FROM Comedor WHERE Nombre LIKE @NombreComedor) 
	SELECT @ComensalBusq = (SELECT IDComensal FROM Comensal WHERE Token LIKE @Token)
	SELECT @TipoRacionBusq = (SELECT IDTipoRacion FROM TipoRacion WHERE Tipo LIKE @TipoRacion)
	
	INSERT INTO Asistencia 
	VALUES (@ComedorBusq, @ComensalBusq, @TipoRacionBusq, @Raciones, @Fecha)
END;
GO

-- APP COM --
--Encuesta
CREATE OR ALTER PROCEDURE PROC_IEncuesta
@NombreComedor AS VARCHAR(30), @Pregunta AS VARCHAR(60), 
@Comentarios AS VARCHAR(80), @Calificacion AS INT, @Fecha AS DATE
AS
BEGIN	
	DECLARE @ComedorBusq AS INT;
	DECLARE @PreguntaBusq AS INT;

	SELECT @ComedorBusq = (SELECT IDComedor FROM Comedor WHERE Nombre LIKE @NombreComedor)
	SELECT @PreguntaBusq = (SELECT IDPregunta FROM Pregunta WHERE Pregunta LIKE @Pregunta)

	INSERT INTO Encuesta 
	VALUES (@ComedorBusq, @PreguntaBusq, @Comentarios, @Calificacion, @Fecha)
END;
GO




-- SP para Consultar Datos

-- WEB --
--Login de Empleados (Supervisores)
CREATE OR ALTER PROCEDURE PROC_LoginEmpS
@NombreUsario AS VARCHAR(40), @Contraseña AS VARCHAR(96),
@Exito AS BIT OUTPUT
AS
BEGIN
	DECLARE @ContraseñaGuardada AS VARCHAR(96);
	SELECT @ContraseñaGuardada = (SELECT Contraseña FROM Empleado WHERE 
	(NombreUsario LIKE @NombreUsario) AND (IDRol = 1));

	DECLARE @Sal AS VARCHAR(32);
	SELECT @Sal = SUBSTRING(@ContraseñaGuardada, 1, 32);

	DECLARE @ContraseñaHash AS VARCHAR(96);
	SELECT @ContraseñaHash = @Sal + CONVERT(VARCHAR(64), HASHBYTES('SHA2_256', @Sal + @Contraseña), 2);

	SELECT @Exito = (CASE WHEN @ContraseñaHash = @ContraseñaGuardada THEN 1 ELSE 0 END);
END;
GO

--Empleados (Supervisores)
CREATE OR ALTER PROCEDURE PROC_CEmpleadoS
@NumeroPag AS INT
AS
BEGIN
	SELECT IDEmpleado, Nombre, ApellidoP, ApellidoM, FechaNacim, Descripcion AS Sexo, NombreUsario
	FROM Empleado 
	JOIN Sexo ON Empleado.IDSexo = Sexo.IDSexo
	WHERE IDRol = 1
	ORDER BY IDEmpleado ASC 
	OFFSET (@NumeroPag - 1) * 5 ROWS
	FETCH NEXT 5 ROWS ONLY;
END;
GO

--Empleados (Encargados)
CREATE OR ALTER PROCEDURE PROC_CEmpleadoE
@NumeroPag AS INT
AS
BEGIN
	SELECT IDEmpleado, Nombre, ApellidoP, ApellidoM, FechaNacim, Descripcion AS Sexo, Correo, NombreUsario
	FROM Empleado 
	JOIN Sexo ON Empleado.IDSexo = Sexo.IDSexo
	WHERE IDRol = 2
	ORDER BY IDEmpleado ASC 
	OFFSET (@NumeroPag - 1) * 5 ROWS
	FETCH NEXT 5 ROWS ONLY;
END;
GO

--Comedor
CREATE OR ALTER PROCEDURE PROC_CComedor
@NumeroPag AS INT
AS
BEGIN
	SELECT IDComedor, Empleado.Correo, EstadoComedor.Nombre AS Estado, Comedor.Nombre, Capacidad, Direccion, Telefono
	FROM Comedor
	JOIN Empleado ON Comedor.IDEmpleado = Empleado.IDEmpleado
	JOIN EstadoComedor ON Comedor.IDEstado = EstadoComedor.IDEstadoComedor
	
	ORDER BY IDComedor ASC 
	OFFSET (@NumeroPag - 1) * 5 ROWS
	FETCH NEXT 5 ROWS ONLY;
END;
GO

--<Sección de "Vista general de comedores">
--Comedores con mayor asistencia
CREATE OR ALTER PROCEDURE PROC_CMayorAsis
@Fecha AS DATE
AS
BEGIN
	SELECT TOP 5 Comedor.Nombre, COUNT(Raciones) AS Visitas
	FROM Asistencia
	JOIN Comedor ON Asistencia.IDComedor = Comedor.IDComedor
	WHERE Fecha LIKE @Fecha
	GROUP BY Asistencia.IDComedor, Comedor.Nombre
	ORDER BY Visitas DESC
END;
GO

--Raciones pagadas vs donadas
CREATE OR ALTER PROCEDURE PROC_CPagarDonar
@Fecha AS DATE
AS
BEGIN
	SELECT COUNT(Raciones) AS Pagada, 
	(SELECT COUNT(Raciones) FROM Asistencia WHERE (IDTipoRacion = 2) AND (Fecha LIKE @Fecha)) AS Donada
	FROM Asistencia
	WHERE (IDTipoRacion = 1) AND (Fecha LIKE @Fecha)
END;
GO

--Edades
CREATE OR ALTER PROCEDURE PROC_CEdades
@Fecha AS DATE
AS
BEGIN
	SELECT
    CASE
		WHEN YEAR(GETDATE()) - FechaNacim BETWEEN 0 AND 5 THEN 'Menor a 5 años'
        WHEN YEAR(GETDATE()) - FechaNacim BETWEEN 6 AND 25 THEN '6-25 años'
        WHEN YEAR(GETDATE()) - FechaNacim BETWEEN 26 AND 35 THEN '26-35 años'
        WHEN YEAR(GETDATE()) - FechaNacim BETWEEN 36 AND 45 THEN '36-45 años'
        WHEN YEAR(GETDATE()) - FechaNacim BETWEEN 46 AND 64 THEN '46-64 años'
        ELSE 'Más de 65 años'
    END AS RangoEdades,
    COUNT(*) AS Cantidad
	FROM Asistencia
	JOIN Comensal ON Asistencia.IDComensal = Comensal.IDComensal
	WHERE (Fecha LIKE @Fecha) AND (FechaNacim IS NOT NULL)
	GROUP BY
    CASE
        WHEN YEAR(GETDATE()) - FechaNacim BETWEEN 0 AND 5 THEN 'Menor a 5 años'
        WHEN YEAR(GETDATE()) - FechaNacim BETWEEN 6 AND 25 THEN '6-25 años'
        WHEN YEAR(GETDATE()) - FechaNacim BETWEEN 26 AND 35 THEN '26-35 años'
        WHEN YEAR(GETDATE()) - FechaNacim BETWEEN 36 AND 45 THEN '36-45 años'
        WHEN YEAR(GETDATE()) - FechaNacim BETWEEN 46 AND 64 THEN '46-64 años'
        ELSE 'Más de 65 años'
    END
ORDER BY RangoEdades;
END;
GO

--Condiciones
CREATE OR ALTER PROCEDURE PROC_CCondiciones
@Fecha AS DATE
AS
BEGIN
	SELECT DISTINCT Condicion.Nombre, COUNT(Condicion.Nombre) AS Veces
	FROM Asistencia
	JOIN Comensal ON Asistencia.IDComensal = Comensal.IDComensal
	JOIN CondicionComensal ON Comensal.IDComensal = CondicionComensal.IDComensal
	JOIN Condicion ON CondicionComensal.IDCondicion = Condicion.IDCondicion
	WHERE Fecha LIKE @Fecha
	GROUP BY Condicion.Nombre
END;
GO

--Encuesta
CREATE OR ALTER PROCEDURE PROC_CEncuesta
@NombreComedor AS VARCHAR(30), @Fecha AS DATE
AS
BEGIN
	DECLARE @ComedorBusq AS INT;

	SELECT @ComedorBusq = (SELECT IDComedor FROM Comedor WHERE Nombre LIKE @NombreComedor) 
	
	SELECT Pregunta, Comentarios, Calificacion
	FROM Encuesta
	JOIN Pregunta ON Encuesta.IDPregunta = Pregunta.IDPregunta
	WHERE (IDComedor = @ComedorBusq) AND (Fecha LIKE @Fecha)
END;
GO




--<Sección de "Vista por comedor">
--Asistencias de los comensales por fecha 
CREATE OR ALTER PROCEDURE PROC_CAsisComensales
@NombreComedor AS VARCHAR(30), @Fecha AS DATE
AS
BEGIN
	DECLARE @ComedorBusq AS INT;

	SELECT @ComedorBusq = (SELECT IDComedor FROM Comedor WHERE Nombre LIKE @NombreComedor) 

	SELECT Nombre, ApellidoP, ApellidoM, COUNT(Asistencia.IDComensal) AS Visita
	FROM Asistencia
	JOIN Comensal ON Asistencia.IDComensal = Comensal.IDComensal
	WHERE (Fecha LIKE @Fecha) AND (IDComedor = @ComedorBusq)
	GROUP BY Nombre, ApellidoP, ApellidoM
END;
GO

--Población dentro del comedor
CREATE OR ALTER PROCEDURE PROC_CPoblaCome
@NombreComedor AS VARCHAR(30), @Fecha AS DATE
AS
BEGIN
	DECLARE @ComedorBusq AS INT;

	SELECT @ComedorBusq = (SELECT IDComedor FROM Comedor WHERE Nombre LIKE @NombreComedor) 

	SELECT 
		SUM(CASE WHEN Comensal.IDSexo = 2 THEN 1 ELSE 0 END) AS Mujer,
		SUM(CASE WHEN Comensal.IDSexo = 1 THEN 1 ELSE 0 END) AS Hombre
	FROM Asistencia
	JOIN Comensal ON Asistencia.IDComensal = Comensal.IDComensal
	WHERE (Fecha LIKE @Fecha) AND (IDComedor = @ComedorBusq)
END;
GO

--Historial de la asistencia de los comensales
CREATE OR ALTER PROCEDURE PROC_CHistAsisComen
@NombreComedor AS VARCHAR(30)
AS
BEGIN
	DECLARE @ComedorBusq AS INT;

	SELECT @ComedorBusq = (SELECT IDComedor FROM Comedor WHERE Nombre LIKE @NombreComedor) 

	SELECT Nombre, ApellidoP, ApellidoM, COUNT(Asistencia.IDComensal) AS Visita
	FROM Asistencia
	JOIN Comensal ON Asistencia.IDComensal = Comensal.IDComensal
	WHERE IDComedor = @ComedorBusq
	GROUP BY Nombre, ApellidoP, ApellidoM
END;
GO

--Comidas Donadas
CREATE OR ALTER PROCEDURE PROC_CRacionDonada
@NombreComedor AS VARCHAR(30)
AS
BEGIN
	DECLARE @ComedorBusq AS INT;

	SELECT @ComedorBusq = (SELECT IDComedor FROM Comedor WHERE Nombre LIKE @NombreComedor) 

	SELECT Nombre, ApellidoP, ApellidoM, CURP
	FROM Asistencia
	JOIN Comensal ON Asistencia.IDComensal = Comensal.IDComensal
	WHERE (IDTipoRacion = 2) AND (IDComedor = @ComedorBusq)
END;
GO

--Incidencias (General)
CREATE OR ALTER PROCEDURE PROC_CIncidencias
@Fecha AS DATE
AS
BEGIN	
	SELECT Nombre AS Comedor, Tipo, Descripcion, Fecha 
	FROM Incidencias
	JOIN Comedor ON Incidencias.IDComedor = Comedor.IDComedor 
	WHERE Fecha LIKE @Fecha
END;
GO

-- APP VOL/ENC --
--Login de Empleados (Encargados)
CREATE OR ALTER PROCEDURE PROC_LoginEmpE
@NombreUsario AS VARCHAR(40), @Contraseña AS VARCHAR(96),
@Exito AS BIT OUTPUT
AS
BEGIN
	DECLARE @ContraseñaGuardada AS VARCHAR(96);
	SELECT @ContraseñaGuardada = (SELECT Contraseña FROM Empleado WHERE 
	(NombreUsario LIKE @NombreUsario) AND (IDRol = 2));

	DECLARE @Sal AS VARCHAR(32);
	SELECT @Sal = SUBSTRING(@ContraseñaGuardada, 1, 32);

	DECLARE @ContraseñaHash AS VARCHAR(96);
	SELECT @ContraseñaHash = @Sal + CONVERT(VARCHAR(64), HASHBYTES('SHA2_256', @Sal + @Contraseña), 2);

	SELECT @Exito = (CASE WHEN @ContraseñaHash = @ContraseñaGuardada THEN 1 ELSE 0 END);
END;
GO

--Comedor
CREATE OR ALTER PROCEDURE PROC_CDatosComedor
@NombreUsario AS VARCHAR(40)
AS
BEGIN
	SELECT Correo, Comedor.Nombre
	FROM Empleado
	JOIN Comedor ON Empleado.IDEmpleado = Comedor.IDEmpleado
	WHERE Empleado.NombreUsario LIKE @NombreUsario
END;
GO

--Catálogo "Condición"
CREATE OR ALTER PROCEDURE PROC_CCondicion
AS
BEGIN
	SELECT Nombre
	FROM Condicion
END;
GO

--<Sección de "Dashboard">
--Raciones servidas pagadas
CREATE OR ALTER PROCEDURE PROC_CDashBPt1
@NombreComedor AS VARCHAR(30), @Fecha AS DATE
AS
BEGIN
	DECLARE @ComedorBusq AS INT;

	SELECT @ComedorBusq = (SELECT IDComedor FROM Comedor WHERE Nombre LIKE @NombreComedor)

	SELECT COUNT(Raciones)
	FROM Asistencia
	WHERE (IDComedor = @ComedorBusq) AND (IDTipoRacion = 1) AND (Fecha LIKE @Fecha)
	GROUP BY Fecha
END;
GO

--Raciones donadas
CREATE OR ALTER PROCEDURE PROC_CDashBPt2
@NombreComedor AS VARCHAR(30), @Fecha AS DATE
AS
BEGIN
	DECLARE @ComedorBusq AS INT;

	SELECT @ComedorBusq = (SELECT IDComedor FROM Comedor WHERE Nombre LIKE @NombreComedor)

	SELECT COUNT(Raciones)
	FROM Asistencia
	WHERE (IDComedor = @ComedorBusq) AND (IDTipoRacion = 2) AND (Fecha LIKE @Fecha)
	GROUP BY Fecha
END;
GO

--Número total de comensales
CREATE OR ALTER PROCEDURE PROC_CDashBPt3
@NombreComedor AS VARCHAR(30), @Fecha AS DATE
AS
BEGIN
	DECLARE @ComedorBusq AS INT;

	SELECT @ComedorBusq = (SELECT IDComedor FROM Comedor WHERE Nombre LIKE @NombreComedor)

	SELECT COUNT(Raciones)
	FROM Asistencia
	WHERE (IDComedor = @ComedorBusq) AND (Fecha LIKE @Fecha)
END;
GO

--Dinero Recaudado
CREATE OR ALTER PROCEDURE PROC_CDashBPt4
@NombreComedor AS VARCHAR(30), @Fecha AS DATE
AS
BEGIN
	DECLARE @ComedorBusq AS INT;

	SELECT @ComedorBusq = (SELECT IDComedor FROM Comedor WHERE Nombre LIKE @NombreComedor)

	SELECT SUM(Raciones) * 13
	FROM Asistencia
	WHERE (IDComedor = @ComedorBusq) AND (IDTipoRacion = 1) AND (Fecha LIKE @Fecha)
END;
GO

--LeaderBoard para competición sana entre comedores
CREATE OR ALTER PROCEDURE PROC_CDashBPt5
@Fecha AS DATE
AS
BEGIN
	SELECT Nombre,
		SUM(CASE WHEN IDTipoRacion = 1 THEN 1 ELSE 0 END) AS R_Pagadas,
		SUM(CASE WHEN IDTipoRacion = 2 THEN 1 ELSE 0 END) AS R_Donadas,
		COUNT(IDAsistencia) AS TotalVisitas,
		SUM(CASE WHEN IDTipoRacion = 1 THEN 13 ELSE 0 END) AS MontoRecaudado
	FROM Asistencia
	JOIN Comedor ON Asistencia.IDComedor = Comedor.IDComedor
	WHERE Fecha LIKE @Fecha
	GROUP BY Nombre
END;
GO


-- APP COM --
--Visualizar el menu
CREATE OR ALTER PROCEDURE PROC_CVerMenu
@NombreComedor AS VARCHAR(30), @Fecha AS DATE
AS
BEGIN
	DECLARE @ComedorBusq AS INT;

	SELECT @ComedorBusq = (SELECT IDComedor FROM Comedor WHERE Nombre LIKE @NombreComedor)

	SELECT SopaArroz, PlatoFuerte, PanToritilla, AguaDelDia, FrijolesSalsa
	FROM Menu
	WHERE (IDComedor = @ComedorBusq) AND (Fecha LIKE @Fecha)
END;
GO

--Incidencias (Por Comedor)
CREATE OR ALTER PROCEDURE PROC_CIncidenciasC
@NombreComedor AS VARCHAR(30), @Fecha AS DATE
AS
BEGIN	
	DECLARE @ComedorBusq AS INT;

	SELECT @ComedorBusq = (SELECT IDComedor FROM Comedor WHERE Nombre LIKE @NombreComedor)

	SELECT Tipo, Descripcion, Fecha 
	FROM Incidencias
	WHERE (IDComedor = @ComedorBusq) AND (Fecha LIKE @Fecha)
END;
GO

--*
--Correo de Supervisor para ayuda
CREATE OR ALTER PROCEDURE PROC_CSuperCorreo
AS
BEGIN	
	SELECT Nombre, ApellidoP, Correo
	FROM Empleado
	WHERE IDEmpleado = 1
END;
GO

--Comedor (Catálogo)
CREATE OR ALTER PROCEDURE PROC_NombresCom
AS
BEGIN
	SELECT Comedor.Nombre
	FROM Empleado
	JOIN Comedor ON Empleado.IDEmpleado = Comedor.IDEmpleado
END;
GO

--Estado del Comedor
CREATE OR ALTER PROCEDURE PROC_CEstadoCom
@NombreComedor AS VARCHAR(30)
AS
BEGIN	
	SELECT EstadoComedor.Nombre
	FROM Comedor
	JOIN EstadoComedor ON Comedor.IDEstado = EstadoComedor.IDEstadoComedor
	WHERE Comedor.Nombre LIKE @NombreComedor
END;
GO



-- SP para Actualizar Datos
-- WEB --
--Empleados
CREATE OR ALTER PROCEDURE PROC_AEmpleado
@IDEmpleado AS INT, @Nombre AS VARCHAR(30), @ApellidoP AS VARCHAR(30),
@ApellidoM AS VARCHAR(30), @FechaNacim AS INT, @DescSexo AS VARCHAR(30),
@Correo AS VARCHAR(40), @NombreUsario AS VARCHAR(40)
AS
BEGIN 
	DECLARE @SexoBusq AS INT;

	SELECT @SexoBusq = (SELECT IDSexo FROM Sexo WHERE Descripcion LIKE @DescSexo)

	UPDATE Empleado
	SET Nombre = @Nombre, ApellidoP = @ApellidoP, ApellidoM = @ApellidoM,
	FechaNacim = @FechaNacim, IDSexo = @SexoBusq, Correo = @Correo, 
	NombreUsario = @NombreUsario
	WHERE IDEmpleado = @IDEmpleado
END;
GO

--Contraseña Empleados
CREATE OR ALTER PROCEDURE PROC_AContraEmp
@IDEmpleado AS INT, @Contraseña AS VARCHAR(96)
AS
BEGIN
	UPDATE Empleado
	SET Contraseña = @Contraseña
	WHERE IDEmpleado = @IDEmpleado
END;
GO


--Comedor
CREATE OR ALTER PROCEDURE PROC_AComedor
@IDComedor AS INT, @CorreoEmpleado AS VARCHAR(40), @NombreEstadoC AS VARCHAR(30),
@Nombre AS VARCHAR(30), @Capacidad AS INT, @Direccion AS VARCHAR(50),
@Telefono AS VARCHAR(30)
AS
BEGIN 
	DECLARE @EmpleadoBusq AS INT;
	DECLARE @EstadoComBusq AS INT;

	SELECT @EmpleadoBusq = (SELECT IDEmpleado FROM Empleado WHERE 
	(Correo LIKE @CorreoEmpleado) AND (IDRol = 2));
	SELECT @EstadoComBusq = (SELECT IDEstadoComedor FROM EstadoComedor WHERE Nombre LIKE @NombreEstadoC)
	
	UPDATE Comedor
	SET  IDEmpleado = @EmpleadoBusq, IDEstado = @EstadoComBusq, Nombre = @Nombre,
	Capacidad = @Capacidad, Direccion = @Direccion, Telefono = @Telefono
	WHERE IDComedor = @IDComedor
END;
GO

-- WEB // VOL/ENC --
--Estado del Comedor
CREATE OR ALTER PROCEDURE PROC_AEstadoComedor
@NombreComedor AS VARCHAR(30), @NombreEstadoC AS VARCHAR(30)
AS
BEGIN 
	DECLARE @ComedorBusq AS INT;
	DECLARE @EstadoComBusq AS INT;

	SELECT @ComedorBusq = (SELECT IDComedor FROM Comedor WHERE Nombre LIKE @NombreComedor);
	SELECT @EstadoComBusq = (SELECT IDEstadoComedor FROM EstadoComedor WHERE Nombre LIKE @NombreEstadoC)
	
	UPDATE Comedor
	SET  IDEstado = @EstadoComBusq
	WHERE IDComedor = @ComedorBusq
END;
GO


-- SP para Borrado Datos
-- WEB --
--Empleados
CREATE OR ALTER PROCEDURE PROC_BEmpleado
@NombreUsario AS VARCHAR(40)
AS
BEGIN
	DECLARE @EmpleadoBusq AS INT;

	SELECT @EmpleadoBusq = (SELECT IDEmpleado FROM Empleado WHERE NombreUsario LIKE @NombreUsario);
	
	DELETE FROM Empleado WHERE IDEmpleado = @EmpleadoBusq
END;
GO





-- DML (Llenado de datos)

USE ComedorBD;
GO

-- *Catálogo de Estados para los comedores
INSERT INTO EstadoComedor VALUES ('Abierto');
INSERT INTO EstadoComedor VALUES ('Cerrado');
GO

-- *Catálogo de Tipos de Raciones a servir
INSERT INTO TipoRacion VALUES ('Pagada');
INSERT INTO TipoRacion VALUES ('Donada');
GO

-- *Catálogo para el Sexo de un comensal
INSERT INTO Sexo VALUES ('Hombre');
INSERT INTO Sexo VALUES ('Mujer');
INSERT INTO Sexo VALUES ('Otros');
GO

-- *Catálogo de Condiciones para los comensales 
INSERT INTO Condicion VALUES ('No Aplica');
INSERT INTO Condicion VALUES ('Menor a 5 años');
INSERT INTO Condicion VALUES ('Mayor a 65 años');
INSERT INTO Condicion VALUES ('Embarazada');
INSERT INTO Condicion VALUES ('Sordo');
INSERT INTO Condicion VALUES ('Ciego');
INSERT INTO Condicion VALUES ('Enfermedad Crónica');
--INSERT INTO Condicion VALUES ('Malnutrición')
GO

-- *Catálogo para los Roles de un empleado
INSERT INTO Rol VALUES ('Supervisor');
INSERT INTO Rol VALUES ('Encargado');
GO

-- *Catálogo para las preguntas
INSERT INTO Pregunta VALUES ('Califica la comida (0-10)');
INSERT INTO Pregunta VALUES ('Califica la limpieza (0-10)');
INSERT INTO Pregunta VALUES ('Califica el servicio (0-10)');
GO

-- Empleados
INSERT INTO Empleado VALUES (1, 'Luis Adrián', 'Abarca', 'Gómez', 1985, 1, 'abarca.gomez.luis@comedoresdif.com', 'AbarcaLuis', 'Contra123');
INSERT INTO Empleado VALUES (1, 'Gerardo', 'Ríos', 'Mejía', 1987, 1, 'gerry.rios@comedoresdif.com', 'RiosGerardo', 'ComedorST');
INSERT INTO Empleado VALUES (1, 'Benny', 'Sánchez', 'González', 1990, 1, 'benny_gs@comedoresdif.com', 'SanchezBenny', 'ComedorCM');
INSERT INTO Empleado VALUES (1, 'Ángel', 'Márquez', 'Curiel', 1989, 1, 'angeliu.marqcu@comedoresdif.com', 'MarquezAngel', 'ComedorMM');
INSERT INTO Empleado VALUES (1, 'José Ricardo', 'Moreno', 'Tahuilan', 1988, 1, 'pepe.moreno@comedoresdif.com', 'MorenoJose', 'ComedorCG');
INSERT INTO Empleado VALUES (1, 'Martín', 'Díaz', 'Suárez', 1983, 1, 'martin.suarez@comedoresdif.com', 'MartinDiaz', 'APassword12');

INSERT INTO Empleado VALUES (2, 'Juan Carlos', 'Carro', 'Cruz', 1989, 1, 'carro.cruz@comedoresdif.com', 'CarroJuan', 'Password123');
INSERT INTO Empleado VALUES (2, 'Maria', 'Espinoza', 'Navarro', 1981, 2, 'espinoza.navarro@comedoresdif.com', 'EspinozaMaria', '1234567890');
INSERT INTO Empleado VALUES (2, 'Laura', 'Fernandez', 'Chavez', 1991, 2, 'lfrnandez.chvz@comedoresdif.com', 'FernandezLaura', 'ComedorQI');
INSERT INTO Empleado VALUES (2, 'Armando', 'Torres', 'Índigo', 1985, 1, 'torres.indigo@comedoresdif.com', 'TorresArmando', 'ComedorCR');
INSERT INTO Empleado VALUES (2, 'Elizabeth', 'Lozano', 'Arias', 1984, 2, 'lozano.arias@comedoresdif.com', 'ElizaLozano', 'It26531');
INSERT INTO Empleado VALUES (2, 'Emmanuel', 'Velasco', 'Vega', 1995, 1, 'velasco.vega@comedoresdif.com', 'EmmaVelasco', 'CieloqweRa');
GO

-- Comedores
INSERT INTO Comedor VALUES (7, 1, 'Cristo del Rodeo', 55, 'DireccionGenericaCR', '5561859871');
INSERT INTO Comedor VALUES (8, 1, 'Santiago Tlatelolco', 65, 'DireccionGenericaST', '556841203971');
INSERT INTO Comedor VALUES (9, 1, 'Cinco de Mayo', 85, 'DireccionGenericaCM', '555463178025');
INSERT INTO Comedor VALUES (10, 1, 'Monte María', 55, 'DireccionGenericaMM', '5568144872123');
GO

-- Menú
INSERT INTO Menu VALUES (1, 'Sopa de caracol', 'Enchiladas', 'Tortillas', 'Agua de Limón', 'Chiles en vinagre', 13.00, '2023-09-12');
INSERT INTO Menu VALUES (1, 'Arroz rojo', 'Nopales con Cilantro', 'Tortillas', 'Agua simple', 'Fijoles', 13.00, '2023-09-13');
INSERT INTO Menu VALUES (2, 'Arroz blanco', 'Torta de papa', 'Pan bolillo', 'Agua de Jamaica', 'Salsa roja',  13.00, '2023-09-12');
INSERT INTO Menu VALUES (2, '', 'Caldo de Pollo con Verduras', 'Tortillas', 'Agua simple', '', 13.00, '2023-09-13');
INSERT INTO Menu VALUES (3, 'Sopa de fideos', 'Bisteces con hígado cebollado', 'Pan salado', 'Agua de Horchata', 'Frijoles', 13.00, '2023-09-12');
INSERT INTO Menu VALUES (3, 'Arroz blanco', 'Chicharron en salsa', 'Pan bolillo', 'Agua de Tamarindo', 'Salsa verde', 13.00, '2023-09-13');
INSERT INTO Menu VALUES (4, 'Sopa de pollo', 'Arrachera', 'Tortillas', 'Agua de sandía', 'Frijoles', 13.00, '2023-09-12');
INSERT INTO Menu VALUES (4, 'Arroz rojo', 'Albondigas', 'Tortillas', 'Agua simple', 'Chiles en vinagre', 13.00, '2023-09-13');
GO

-- Incidencias
INSERT INTO Incidencias VALUES (1, 'Apertura tardía', 'Encargado de llaves tuvo un problema', '2023-09-20');
GO

-- Encuesta
INSERT INTO Encuesta VALUES (1, 1, 'Me quede con hambre', 4, '2023-10-01');
INSERT INTO Encuesta VALUES (1, 2, 'N/A', 8, '2023-10-01');
INSERT INTO Encuesta VALUES (1, 3, 'Me atendieron de malas', 6, '2023-10-01');
GO

-- Comensales
INSERT INTO Comensal (Nombre, ApellidoP, CURP, Token) VALUES ('Persona', 'Genérica', 'ABCD123456EFGHIJK7', 1000);
INSERT INTO Comensal VALUES ('Alfredo', 'Azamar', 'López', 'AALA031210HDFZPLA7', 2003, 1, 1010);
INSERT INTO Comensal VALUES ('Marco', 'Cortes', 'Sandoval', 'MCCS125468OIFBDXT1', 1889, 1, 1020);
INSERT INTO Comensal VALUES ('Daniel', 'Méndez', 'Ramos', 'DAMR235678QWDFGHU7', 2019, 1, 1030);
INSERT INTO Comensal VALUES ('Sofia', 'Luna', 'Guerrero', 'SFLG120936SLDJCNE4', 2018, 2, 1040);
INSERT INTO Comensal VALUES ('Jesús', 'Estrada', 'López', 'JUEL345092XWIJBSH8', 1951, 1, 1050);
INSERT INTO Comensal VALUES ('Fernanda', 'González', 'Morales', 'FGSM234567PONDLAE2', 1995, 2, 1060);
INSERT INTO Comensal VALUES ('Andrea', 'Cruz', 'Rivera', 'ANCR345389YCADHLP5', 1999, 2, 1070);
INSERT INTO Comensal VALUES ('Valerio', 'Rojas', 'Castro', 'VLRC129237ABXMEIR9', 1981, 1, 1080);
INSERT INTO Comensal VALUES ('Rebeca', 'Torres', 'Valle', 'ZRUB239845SLFURB3', 2001, 2, 1090);
INSERT INTO Comensal VALUES ('Omar', 'Cevilla', 'Estrada', 'OCLE984565MNBVSR8', 2000, 1, 1100);
GO

-- Condiciones de los comensales
INSERT INTO CondicionComensal VALUES (1, 1);
INSERT INTO CondicionComensal VALUES (2, 1);
INSERT INTO CondicionComensal VALUES (3, 1);
INSERT INTO CondicionComensal VALUES (4, 2);
INSERT INTO CondicionComensal VALUES (4, 5);
INSERT INTO CondicionComensal VALUES (5, 2);
INSERT INTO CondicionComensal VALUES (6, 3);
INSERT INTO CondicionComensal VALUES (6, 5);
INSERT INTO CondicionComensal VALUES (7, 4);
INSERT INTO CondicionComensal VALUES (8, 4);
INSERT INTO CondicionComensal VALUES (9, 5);
INSERT INTO CondicionComensal VALUES (9, 6);
INSERT INTO CondicionComensal VALUES (10, 7);
INSERT INTO CondicionComensal VALUES (11, 5);
GO

-- Asistencia
INSERT INTO Asistencia VALUES (1, 1, 2, 1, '2023-09-17');
INSERT INTO Asistencia VALUES (1, 2, 1, 1, '2023-09-17');
INSERT INTO Asistencia VALUES (1, 3, 2, 1, '2023-09-19');
INSERT INTO Asistencia VALUES (1, 10, 1, 1, '2023-09-17');
INSERT INTO Asistencia VALUES (2, 4, 1, 1, '2023-09-16');
INSERT INTO Asistencia VALUES (2, 7, 2, 1, '2023-09-17');
INSERT INTO Asistencia VALUES (2, 4, 1, 1, '2023-09-17');
INSERT INTO Asistencia VALUES (2, 5, 1, 1, '2023-09-17');
INSERT INTO Asistencia VALUES (2, 5, 2, 1, '2023-09-20');
INSERT INTO Asistencia VALUES (3, 6, 1, 1, '2023-09-17');
INSERT INTO Asistencia VALUES (3, 7, 1, 1, '2023-09-18');
INSERT INTO Asistencia VALUES (3, 6, 2, 1, '2023-09-18');
INSERT INTO Asistencia VALUES (4, 11, 1, 1, '2023-09-17');
INSERT INTO Asistencia VALUES (4, 8, 1, 1, '2023-09-17');
INSERT INTO Asistencia VALUES (4, 9, 1, 1, '2023-09-17');
INSERT INTO Asistencia VALUES (4, 9, 2, 1, '2023-09-21');
GO


-- PRUEBAS 

USE ComedorBD;
GO

-- SPs
--INSERTAR
-- WEB --
EXECUTE PROC_IEmpleadoS 'Fernando', 'Carrillo', 'Mateos', 1989, 'Hombre', 'carr.fernando@comedoresdif.com', 'FerCarrillo', '456Contra123';
GO

EXECUTE PROC_IEmpleadoE 'Sofía', 'Vidal', 'Suárez',  1990, 'Mujer', 'suarez.vidal@comedoresdif.com', 'VidalSofia', 'MyPassword';
GO

EXECUTE PROC_IComedor 'lozano.arias@comedoresdif.com', 'Abierto', 'Lago de Guadalupe', 69, 'DireccionGenericaLG', '55456789081';
GO

-- APP VOL/ENC --
EXECUTE PROC_IMenu 'Lago de Guadalupe', 'Sopa de Tortilla', 'Milanesas', 'Pan salado', 'Agua de Limón', 'Frijoles', '2023-09-17';
GO

EXECUTE PROC_IIncidencias 'Lago de Guadalupe', 'Fuga de gas', 'La cocina tuvó una fuga de gas', '2023-09-21';
GO

EXECUTE PROC_IComensal 'Matias', 'Hernández', 'Aguirre', 'MHZA658912ASMNJYG9', 1999, 'Hombre', 1110;
EXECUTE PROC_ICondCom 'MHZA658912ASMNJYG9', 'No Aplica';
GO

EXECUTE PROC_IAsistenciaC 'Lago de Guadalupe', 'Pagada', 1, '2023-09-18', 'OCLE984565MNBVSR8';
GO

EXECUTE PROC_IAsistenciaT 'Lago de Guadalupe', 'Donada', 1, '2023-09-17', 1110;
GO

-- APP COM --
EXECUTE PROC_IEncuesta 'Lago de Guadalupe', 'Califica la comida (0-10)', 'Una comida bien servida', 8, '2023-10-04'
EXECUTE PROC_IEncuesta 'Lago de Guadalupe', 'Califica la limpieza (0-10)', 'Limpio, pero podía mejorar', 7, '2023-10-04'
EXECUTE PROC_IEncuesta 'Lago de Guadalupe', 'Califica el servicio (0-10)', 'Muy bien servicio', 9, '2023-10-04'
GO


--CONSULTAR

-- WEB --
DECLARE @Exito AS BIT;
EXECUTE PROC_LoginEmpS 'AbarcaLuis', 'Contra123', @Exito OUTPUT;
SELECT @Exito;
GO

EXECUTE PROC_CEmpleadoS 1;
GO

EXECUTE PROC_CEmpleadoE 1;
GO

EXECUTE PROC_CComedor 1;
GO

--<Sección de "Vista general de comedores">
EXECUTE PROC_CMayorAsis '2023-09-17';
GO

EXECUTE PROC_CPagarDonar '2023-09-17';
GO

EXECUTE PROC_CEdades '2023-09-17';
GO

EXECUTE PROC_CCondiciones '2023-09-18';
GO

EXECUTE PROC_CEncuesta 'Cristo del Rodeo', '2023-10-01';
GO

--<Sección de "Vista por comedor">
EXECUTE PROC_CAsisComensales 'Santiago Tlatelolco', '2023-09-17';
GO

EXECUTE PROC_CPoblaCome 'Santiago Tlatelolco', '2023-09-17';
GO

EXECUTE PROC_CHistAsisComen 'Santiago Tlatelolco';
GO

EXECUTE PROC_CRacionDonada 'Santiago Tlatelolco';
GO

EXECUTE PROC_CIncidencias '2023-09-20';
GO

-- APP VOL/ENC --
DECLARE @Exito1 AS BIT;
EXECUTE PROC_LoginEmpE 'CarroJuan', 'Password123', @Exito1 OUTPUT;
SELECT @Exito1;
GO

EXECUTE PROC_CDatosComedor 'FernandezLaura';
GO

EXECUTE PROC_CCondicion;
GO

--<Sección de "Dashboard">
EXECUTE PROC_CDashBPt1 'Santiago Tlatelolco', '2023-09-17';
GO

EXECUTE PROC_CDashBPt2 'Santiago Tlatelolco', '2023-09-17';
GO

EXECUTE PROC_CDashBPt3 'Santiago Tlatelolco', '2023-09-17';
GO

EXECUTE PROC_CDashBPt4 'Santiago Tlatelolco', '2023-09-17';
GO

EXECUTE PROC_CDashBPt5 '2023-09-17';
GO

-- APP COM --
EXECUTE PROC_CVerMenu 'Santiago Tlatelolco', '2023-09-12';
GO

EXECUTE PROC_CIncidenciasC 'Cristo del Rodeo', '2023-09-20';
GO

EXECUTE PROC_CSuperCorreo;
GO

EXECUTE PROC_NombresCom;
GO

EXECUTE PROC_CEstadoCom 'Santiago Tlatelolco';
GO


--ACTUALIZAR
-- WEB --
EXECUTE PROC_AEmpleado 7, 'Juan Pedro', 'Carro', 'Cruz', 1990, 'Hombre', 'carro.cruz@comedoresdif.com', 'PedroCarro';
GO

EXECUTE PROC_AContraEmp 1, 'LOLSOKCSOJCS';
GO

EXECUTE PROC_AComedor 2, 'espinoza.navarro@comedoresdif.com', 'Abierto', 'Santiago Tlatelolco', 55, 'NuevaDireccionGenericaST', '5597134567907'
GO

-- WEB // APP COM/ENC --
EXECUTE PROC_AEstadoComedor 'Lago de Guadalupe', 'Cerrado';
GO

--BORRAR
-- WEB --
EXECUTE PROC_BEmpleado 'FerCarrillo';
GO



--Vistas 
SELECT * FROM Empleado

SELECT * FROM Comedor

SELECT * FROM Menu

SELECT * FROM Incidencias