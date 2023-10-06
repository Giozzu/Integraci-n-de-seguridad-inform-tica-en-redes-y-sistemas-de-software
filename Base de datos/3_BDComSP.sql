USE ComedorBD;
GO

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