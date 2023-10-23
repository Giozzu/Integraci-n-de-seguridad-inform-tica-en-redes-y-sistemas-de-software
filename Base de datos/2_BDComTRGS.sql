-- ---------------------------------------------------------
-- Nombre del Script: 2_BDComTRGS.sql
-- Propósito: Creación de los Triggers para el modelado.
-- Fecha de Creación: 2023-09-17
-- Autor: Alfredo Azamar López
-- ---------------------------------------------------------

USE ComedorBD;
GO


-- ---------------------------------------------------------
-- Nombre del Trigger: TRG_Empleado_INSERT
-- Propósito: Realizar la encriptación de la contraseña 
--			  de los empleados.
-- ---------------------------------------------------------
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
	DECLARE @NombreUsuario AS VARCHAR(40);
	DECLARE @Contraseña AS VARCHAR(64);
	
	SELECT @IDRol = (SELECT IDRol FROM inserted);
	SELECT @Nombre = (SELECT Nombre FROM inserted);
	SELECT @ApellidoP = (SELECT ApellidoP FROM inserted);
	SELECT @ApellidoM = (SELECT ApellidoM FROM inserted);
	SELECT @FechaNacim = (SELECT FechaNacim FROM inserted);
	SELECT @Correo = (SELECT Correo FROM inserted)
	SELECT @IDSexo = (SELECT IDSexo FROM inserted);
	SELECT @NombreUsuario = (SELECT NombreUsuario FROM inserted);
	SELECT @Contraseña = (SELECT Contraseña FROM inserted);
	
	DECLARE @Sal AS VARCHAR(32);
	SELECT @Sal = CONVERT(VARCHAR(32), CRYPT_GEN_RANDOM(16), 2);

	DECLARE @ContraseñaHash AS VARCHAR(96);
	SELECT @ContraseñaHash = @Sal + CONVERT(VARCHAR(64), HASHBYTES('SHA2_256', @Sal + @Contraseña), 2);
	
	INSERT INTO Empleado
	VALUES (@IDRol, @Nombre, @ApellidoP, @ApellidoM, @FechaNacim, @IDSexo, @Correo, @NombreUsuario, @ContraseñaHash);
END;
GO


-- ---------------------------------------------------------
-- Nombre del Trigger: TRG_Empleado_Contra
-- Propósito: Realizar la encriptación de la contraseña 
--			  de los empleados al actualizar sus datos.
-- ---------------------------------------------------------
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
