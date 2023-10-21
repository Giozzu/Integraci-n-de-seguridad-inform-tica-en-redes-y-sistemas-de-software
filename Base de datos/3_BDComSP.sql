USE ComedorBD;
GO

-- SP para Insertar Datos
-- WEB --
--Empleados (Supervisores)
CREATE OR ALTER PROCEDURE PROC_IEmpleadoS
@Nombre AS VARCHAR(30), @ApellidoP AS VARCHAR(30), @ApellidoM AS VARCHAR(30),
@FechaNacim AS INT, @DescSexo AS VARCHAR(30), @Correo AS VARCHAR(40), 
@NombreUsuario AS VARCHAR(40), @Contraseña AS VARCHAR(96)
AS
BEGIN
	DECLARE @SexoBusq AS INT;

	SELECT @SexoBusq = (SELECT IDSexo FROM Sexo WHERE Descripcion LIKE @DescSexo) 
	
	INSERT INTO Empleado 
	VALUES (1, @Nombre, @ApellidoP, @ApellidoM, @FechaNacim, @SexoBusq, @Correo, @NombreUsuario, @Contraseña)
END;
GO

--Empleados (Encargados)
CREATE OR ALTER PROCEDURE PROC_IEmpleadoE
@Nombre AS VARCHAR(30), @ApellidoP AS VARCHAR(30), @ApellidoM AS VARCHAR(30),
@FechaNacim AS INT, @DescSexo AS VARCHAR(30), @Correo AS VARCHAR(40), 
@NombreUsuario AS VARCHAR(40), @Contraseña AS VARCHAR(96)
AS
BEGIN
	DECLARE @SexoBusq AS INT;

	SELECT @SexoBusq = (SELECT IDSexo FROM Sexo WHERE Descripcion LIKE @DescSexo)

	INSERT INTO Empleado 
	VALUES (2, @Nombre, @ApellidoP, @ApellidoM, @FechaNacim, @SexoBusq, @Correo, @NombreUsuario, @Contraseña)
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
CREATE OR ALTER PROCEDURE PROC_AMenu
@NombreComedor AS VARCHAR(30), @SopaArroz AS VARCHAR(50), @PlatoFuerte AS VARCHAR(50),
@PanTortilla AS VARCHAR(50), @AguaDelDia AS VARCHAR(30), @FrijolesSalsa AS VARCHAR(50),
@Fecha AS DATE
AS
BEGIN
	DECLARE @ComedorBusq AS INT;

	SELECT @ComedorBusq = (SELECT IDComedor FROM Comedor WHERE Nombre LIKE @NombreComedor) 
	
	UPDATE Menu
	SET SopaArroz = @SopaArroz, PlatoFuerte = @PlatoFuerte, 
	PanTortilla = @PanTortilla, AguaDelDia = @AguaDelDia, 
	FrijolesSalsa = @FrijolesSalsa, Precio = 13.00, 
	Fecha = @Fecha
	WHERE IDComedor = @ComedorBusq
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
	
	INSERT INTO Incidencia
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
@NombreUsuario AS VARCHAR(40), @Contraseña AS VARCHAR(96),
@Exito AS BIT OUTPUT
AS
BEGIN
	DECLARE @ContraseñaGuardada AS VARCHAR(96);
	SELECT @ContraseñaGuardada = (SELECT Contraseña FROM Empleado WHERE 
	(NombreUsuario LIKE @NombreUsuario) AND (IDRol = 1));

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
	SELECT IDEmpleado, Nombre, ApellidoP, ApellidoM, FechaNacim, Descripcion AS Sexo, NombreUsuario
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
	SELECT IDEmpleado, Nombre, ApellidoP, ApellidoM, FechaNacim, Descripcion AS Sexo, Correo, NombreUsuario
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
		WHEN YEAR(GETDATE()) - FechaNacim BETWEEN 0 AND 5 THEN 'Primera Infancia'
        WHEN YEAR(GETDATE()) - FechaNacim BETWEEN 6 AND 11 THEN 'Infancia'
        WHEN YEAR(GETDATE()) - FechaNacim BETWEEN 12 AND 17 THEN 'Adolescencia'
        WHEN YEAR(GETDATE()) - FechaNacim BETWEEN 18 AND 59 THEN 'Adultos'
        ELSE 'Personas Tercera Edad'
    END AS RangoEdades,
    COUNT(*) AS Cantidad
	FROM Asistencia
	JOIN Comensal ON Asistencia.IDComensal = Comensal.IDComensal
	WHERE (Fecha LIKE @Fecha) AND (FechaNacim IS NOT NULL)
	GROUP BY
    CASE
        WHEN YEAR(GETDATE()) - FechaNacim BETWEEN 0 AND 5 THEN 'Primera Infancia'
        WHEN YEAR(GETDATE()) - FechaNacim BETWEEN 6 AND 11 THEN 'Infancia'
        WHEN YEAR(GETDATE()) - FechaNacim BETWEEN 12 AND 17 THEN 'Adolescencia'
        WHEN YEAR(GETDATE()) - FechaNacim BETWEEN 18 AND 59 THEN 'Adultos'
        ELSE 'Personas Tercera Edad'
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
	FROM Incidencia
	JOIN Comedor ON Incidencia.IDComedor = Comedor.IDComedor 
	WHERE Fecha LIKE @Fecha
END;
GO

-- APP VOL/ENC --
--Login de Empleados (Encargados)
CREATE OR ALTER PROCEDURE PROC_LoginEmpE
@NombreUsuario AS VARCHAR(40), @Contraseña AS VARCHAR(96),
@Exito AS BIT OUTPUT
AS
BEGIN
    DECLARE @ContraseñaGuardada AS VARCHAR(96);
    DECLARE @Sal AS VARCHAR(32);
    DECLARE @ContraseñaHash AS VARCHAR(96);

    SELECT @ContraseñaGuardada = Contraseña, @Sal = SUBSTRING(Contraseña, 1, 32)
    FROM Empleado
    WHERE NombreUsuario LIKE @NombreUsuario AND IDRol = 2;

    SET @ContraseñaHash = @Sal + CONVERT(VARCHAR(64), HASHBYTES('SHA2_256', @Sal + @Contraseña), 2);

    SELECT Comedor.Nombre
    FROM Empleado
    JOIN Comedor ON Empleado.IDEmpleado = Comedor.IDEmpleado
    WHERE Empleado.NombreUsuario LIKE @NombreUsuario;

    SET @Exito = CASE WHEN @ContraseñaHash = @ContraseñaGuardada THEN 1 ELSE 0 END;
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
CREATE OR ALTER PROCEDURE PROC_CDashBoard
@NombreComedor AS VARCHAR(30), @Fecha AS DATE
AS
BEGIN
    DECLARE @ComedorBusq AS INT;

    SELECT @ComedorBusq = (SELECT IDComedor FROM Comedor WHERE Nombre LIKE @NombreComedor);

    CREATE TABLE #Resultados (
        Valor INT
    );

    -- Raciones servidas pagadas
    INSERT INTO #Resultados (Valor)
    SELECT ISNULL(SUM(Raciones), 0)
    FROM Asistencia
    WHERE (IDComedor = @ComedorBusq) AND (IDTipoRacion = 1) AND (Fecha = @Fecha);

    -- Raciones donadas
    INSERT INTO #Resultados (Valor)
    SELECT ISNULL(SUM(Raciones), 0)
    FROM Asistencia
    WHERE (IDComedor = @ComedorBusq) AND (IDTipoRacion = 2) AND (Fecha = @Fecha);

    -- Número total de comensales
    INSERT INTO #Resultados (Valor)
    SELECT ISNULL(SUM(Raciones), 0)
    FROM Asistencia
    WHERE (IDComedor = @ComedorBusq) AND (Fecha = @Fecha);

    -- Dinero Recaudado
    INSERT INTO #Resultados (Valor)
    SELECT ISNULL(SUM(Raciones) * 13, 0)
    FROM Asistencia
    WHERE (IDComedor = @ComedorBusq) AND (IDTipoRacion = 1) AND (Fecha = @Fecha);

    
    SELECT * FROM #Resultados;

    DROP TABLE #Resultados;
END;
GO



--Board para competición sana entre comedores
CREATE OR ALTER PROCEDURE PROC_CDashBoardComp
@NombreComedor AS VARCHAR(30), @Fecha AS DATE
AS
BEGIN
    -- Declarar una tabla variable para almacenar los resultados clasificados
    DECLARE @TopResults TABLE (
        Nombre NVARCHAR(255),
        R_Pagadas INT,
        R_Donadas INT,
        TotalVisitas INT,
        MontoRecaudado INT
    )

    INSERT INTO @TopResults
    SELECT TOP 4 Nombre,
        SUM(CASE WHEN IDTipoRacion = 1 THEN 1 ELSE 0 END) AS R_Pagadas,
        SUM(CASE WHEN IDTipoRacion = 2 THEN 1 ELSE 0 END) AS R_Donadas,
        COUNT(IDAsistencia) AS TotalVisitas,
        SUM(CASE WHEN IDTipoRacion = 1 THEN 13 ELSE 0 END) AS MontoRecaudado
    FROM Asistencia
    JOIN Comedor ON Asistencia.IDComedor = Comedor.IDComedor
    WHERE Fecha = @Fecha
    GROUP BY Nombre
    ORDER BY TotalVisitas DESC;  -- Ordenar por TotalVisitas en orden descendente

    -- Si se especifica un comedor, se inserta en la tabla variable
    IF @NombreComedor IS NOT NULL
    BEGIN
        INSERT INTO @TopResults
        SELECT Nombre,
            SUM(CASE WHEN IDTipoRacion = 1 THEN 1 ELSE 0 END) AS R_Pagadas,
            SUM(CASE WHEN IDTipoRacion = 2 THEN 1 ELSE 0 END) AS R_Donadas,
            COUNT(IDAsistencia) AS TotalVisitas,
            SUM(CASE WHEN IDTipoRacion = 1 THEN 13 ELSE 0 END) AS MontoRecaudado
        FROM Asistencia
        JOIN Comedor ON Asistencia.IDComedor = Comedor.IDComedor
        WHERE Fecha = @Fecha AND Nombre = @NombreComedor
        GROUP BY Nombre;
    END

    -- Seleccionar los resultados de la tabla variable
    SELECT *
    FROM @TopResults;
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

	SELECT SopaArroz, PlatoFuerte, PanTortilla, AguaDelDia, FrijolesSalsa
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
	FROM Incidencia
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
CREATE OR ALTER PROCEDURE PROC_CNombresCom
AS
BEGIN
	SELECT Comedor.Nombre
	FROM Empleado
	JOIN Comedor ON Empleado.IDEmpleado = Comedor.IDEmpleado
END;
GO

--Preguntas de la encuesta (Catálogo)
CREATE OR ALTER PROCEDURE PROC_CPreguntas
AS
BEGIN
	SELECT Pregunta
	FROM Pregunta
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
@Correo AS VARCHAR(40), @NombreUsuario AS VARCHAR(40)
AS
BEGIN 
	DECLARE @SexoBusq AS INT;

	SELECT @SexoBusq = (SELECT IDSexo FROM Sexo WHERE Descripcion LIKE @DescSexo)

	UPDATE Empleado
	SET Nombre = @Nombre, ApellidoP = @ApellidoP, ApellidoM = @ApellidoM,
	FechaNacim = @FechaNacim, IDSexo = @SexoBusq, Correo = @Correo, 
	NombreUsuario = @NombreUsuario
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
@NombreUsuario AS VARCHAR(40)
AS
BEGIN
	DECLARE @EmpleadoBusq AS INT;

	SELECT @EmpleadoBusq = (SELECT IDEmpleado FROM Empleado WHERE NombreUsuario LIKE @NombreUsuario);
	
	DELETE FROM Empleado WHERE IDEmpleado = @EmpleadoBusq
END;
GO
