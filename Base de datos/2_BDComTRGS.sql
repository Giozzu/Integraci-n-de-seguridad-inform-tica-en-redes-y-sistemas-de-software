USE ComedorBD;
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
	DECLARE @NombreUsario AS VARCHAR(40);
	DECLARE @Contraseña AS VARCHAR(64);
	
	SELECT @IDRol = (SELECT IDRol FROM inserted);
	SELECT @Nombre = (SELECT Nombre FROM inserted);
	SELECT @ApellidoP = (SELECT ApellidoP FROM inserted);
	SELECT @ApellidoM = (SELECT ApellidoM FROM inserted);
	SELECT @FechaNacim = (SELECT FechaNacim FROM inserted);
	SELECT @Correo = (SELECT Correo FROM inserted)
	SELECT @NombreUsario = (SELECT NombreUsario FROM inserted);
	SELECT @Contraseña = (SELECT Contraseña FROM inserted);
	
	DECLARE @Sal AS VARCHAR(32);
	SELECT @Sal = CONVERT(VARCHAR(32), CRYPT_GEN_RANDOM(16), 2);

	DECLARE @ContraseñaHash AS VARCHAR(96);
	SELECT @ContraseñaHash = @Sal + CONVERT(VARCHAR(64), HASHBYTES('SHA2_256', @Sal + @Contraseña), 2);
	
	INSERT INTO Empleado
	VALUES (@IDRol, @Nombre, @ApellidoP, @ApellidoM, @FechaNacim, @Correo, @NombreUsario, @ContraseñaHash);
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