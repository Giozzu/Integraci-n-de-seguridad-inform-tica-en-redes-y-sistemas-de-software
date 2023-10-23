-- ---------------------------------------------------------
-- Nombre del Script: 3_BDComSP.sql
-- Propósito: Creación de los Stored Procedures.
-- Fecha de Creación: 2023-09-25
-- Autor: Alfredo Azamar López
-- ---------------------------------------------------------

USE ComedorBD;
GO

/*
Descripción: Insertar un nuevo supervisor.
Parámetros de Entrada:
-- - @Nombre: Nombre del empleado (hasta 30 caracteres).
-- - @ApellidoP: Apellido paterno del empleado (hasta 30 caracteres).
-- - @ApellidoM: Apellido materno del empleado (hasta 30 caracteres).
-- - @FechaNacim: Año de la fecha de nacimiento del empleado.
-- - @DescSexo: Descripción del sexo del empleado (hasta 30 caracteres).
-- - @Correo: Correo electrónico del empleado (hasta 40 caracteres).
-- - @NombreUsuario: Nombre de usuario del empleado (hasta 40 caracteres).
-- - @Contraseña: Contraseña del empleado.
*/
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


/*
Descripción: Insertar un nuevo encargado.
Parámetros de Entrada:
-- - @Nombre: Nombre del empleado (hasta 30 caracteres).
-- - @ApellidoP: Apellido paterno del empleado (hasta 30 caracteres).
-- - @ApellidoM: Apellido materno del empleado (hasta 30 caracteres).
-- - @FechaNacim: Año de la fecha de nacimiento del empleado.
-- - @DescSexo: Descripción del sexo del empleado (hasta 30 caracteres).
-- - @Correo: Correo electrónico del empleado (hasta 40 caracteres).
-- - @NombreUsuario: Nombre de usuario del empleado (hasta 40 caracteres).
-- - @Contraseña: Contraseña del empleado.
*/
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


/*
Descripción: Insertar un nuevo comedor.
Parámetros de Entrada:
-- - @CorreoEmpleado: Correo electrónico del empleado que administra el comedor (hasta 40 caracteres).
-- - @NombreEstadoC: Nombre del estado del comedor (hasta 30 caracteres).
-- - @Nombre: Nombre del comedor (hasta 30 caracteres).
-- - @Capacidad: Capacidad del comedor (entero).
-- - @Direccion: Dirección del comedor (hasta 50 caracteres).
-- - @Telefono: Número de teléfono del comedor (hasta 30 caracteres).
*/
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


/*
Descripción: Actualizar el menú de un comedor.
Parámetros de Entrada:
-- - @NombreComedor: Nombre del comedor al que se le actualizará el menú (hasta 30 caracteres).
-- - @SopaArroz: Nombre de la sopa o arroz del menú (hasta 50 caracteres).
-- - @PlatoFuerte: Nombre del plato fuerte del menú (hasta 50 caracteres).
-- - @PanTortilla: Nombre del pan o tortilla del menú (hasta 50 caracteres).
-- - @AguaDelDia: Nombre del agua del día del menú (hasta 30 caracteres).
-- - @FrijolesSalsa: Nombre de los frijoles o salsa del menú (hasta 50 caracteres).
-- - @Fecha: Fecha en que se aplicará el menú (formato 'YYYY-MM-DD').
*/
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


/*
Descripción: Insertar una nueva incidencia.
Parámetros de Entrada:
-- - @NombreComedor: Nombre del comedor al que se relaciona la incidencia (hasta 30 caracteres).
-- - @Tipo: Tipo de incidencia (hasta 30 caracteres).
-- - @Descripcion: Descripción detallada de la incidencia (hasta 60 caracteres).
-- - @Fecha: Fecha en que se registra la incidencia (formato 'YYYY-MM-DD').
*/
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


/*
Descripción: Insertar un nuevo comensal.
Parámetros de Entrada:
-- - @Nombre: Nombre del comensal (hasta 30 caracteres).
-- - @ApellidoP: Apellido paterno del comensal (hasta 30 caracteres).
-- - @ApellidoM: Apellido materno del comensal (hasta 30 caracteres).
-- - @CURP: Clave Única de Registro de Población del comensal (18 caracteres).
-- - @FechaNacim: Año de la Fecha de nacimiento del comensal (entero).
-- - @DescSexo: Descripción del sexo del comensal (hasta 30 caracteres).
-- - @Token: Valor que representa un token o identificador del comensal.
*/
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


/*
Descripción: Asocia una condición a un comensal.
Parámetros de Entrada:
-- - @ComensalCURP: CURP (Clave Única de Registro de Población) del comensal (18 caracteres).
-- - @NombreCond: Nombre de la condición que se asociará al comensal (hasta 30 caracteres).
*/
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


/*
Descripción: Registrar la asistencia de un comensal en un comedor.
Parámetros de Entrada:
-- - @NombreComedor: Nombre del comedor al que el comensal asistió (hasta 30 caracteres).
-- - @TipoRacion: Tipo de ración servida al comensal (hasta 20 caracteres).
-- - @Raciones: Cantidad de raciones consumidas por el comensal (entero).
-- - @Fecha: Fecha en que se registró la asistencia (formato 'YYYY-MM-DD').
-- - @ComensalCURP: CURP (Clave Única de Registro de Población) del comensal (18 caracteres).
*/
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


/*
Descripción: Registrar la asistencia de un comensal en un comedor.
Parámetros de Entrada:
-- - @NombreComedor: Nombre del comedor al que el comensal asistió (hasta 30 caracteres).
-- - @TipoRacion: Tipo de ración servida al comensal (hasta 20 caracteres).
-- - @Raciones: Cantidad de raciones consumidas por el comensal (entero).
-- - @Fecha: Fecha en que se registró la asistencia (formato 'YYYY-MM-DD').
-- - @Token: Token de identificación del comensal (entero).
*/
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


/*
Descripción: Registrar una encuesta sobre un comedor.
Parámetros de Entrada:
-- - @NombreComedor: Nombre del comedor sobre el que se realiza la encuesta (hasta 30 caracteres).
-- - @Pregunta: Pregunta o tema de la encuesta (hasta 60 caracteres).
-- - @Comentarios: Comentarios o respuestas a la encuesta (hasta 80 caracteres).
-- - @Calificacion: Calificación de la encuesta (entero).
-- - @Fecha: Fecha en que se registró la encuesta (formato 'YYYY-MM-DD').
*/
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


/*
Descripción: Verificar el inicio de sesión de un empleado supervisor.
-- Parámetros de Entrada
-- - @NombreUsuario: Nombre de usuario del empleado que intenta iniciar sesión.
-- - @Contraseña: Contraseña proporcionada por el empleado para iniciar sesión.

-- Parámetros de Salida
-- - @Exito: Valor de bit que indica si el inicio de sesión fue exitoso (1) o no (0).
*/
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


/*
Descripción: Consultar y listar supervisores en base a la paginación.
Parámetros de Entrada:
-- - @NumeroPag: Número de página para la paginación de resultados (entero).
*/
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


/*
Descripción: Consultar y listar encargados en base a la paginación.
Parámetros de Entrada:
-- - @NumeroPag: Número de página para la paginación de resultados (entero).
*/
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


/*
Descripción: Consultar y listar comedores en base a la paginación.
Parámetros de Entrada:
-- - @NumeroPag: Número de página para la paginación de resultados (entero).
*/
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


/*
Descripción: Consultar los 5 comedores con mayor asistencia en una fecha específica.
Parámetros de Entrada:
-- - @Fecha: Fecha para la cual se desea consultar la asistencia (formato 'YYYY-MM-DD').
*/
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


/*
Descripción: Consultar el número de raciones pagadas y donadas en una fecha específica.
Parámetros de Entrada:
-- - @Fecha: Fecha para la cual se desea consultar la asistencia (formato 'YYYY-MM-DD').
*/
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


/*
Descripción: Consultar y contar la cantidad de comensales en diferentes rangos de edades en una fecha específica.
Parámetros de Entrada:
-- - @Fecha: Fecha para la cual se desea consultar la asistencia (formato 'YYYY-MM-DD').
*/
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


/*
Descripción: Consultar y contar la cantidad de comensales con diferentes condiciones de salud en una fecha específica.
Parámetros de Entrada:
-- - @Fecha: Fecha para la cual se desea consultar la asistencia (formato 'YYYY-MM-DD').
*/
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


/*
Descripción: Consultar las respuestas de encuestas para un comedor específico en una fecha dada.
Parámetros de Entrada:
-- - @NombreComedor: Nombre del comedor para el cual se desean consultar las respuestas de encuestas.
-- - @Fecha: Fecha para la cual se desea consultar la asistencia (formato 'YYYY-MM-DD').
*/
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


/*
Descripción: Consultar y contar la asistencia de comensales a un comedor específico en una fecha dada.
Parámetros de Entrada:
-- - @NombreComedor: Nombre del comedor para el cual se desean consultar las respuestas de encuestas.
-- - @Fecha: Fecha para la cual se desea consultar la asistencia (formato 'YYYY-MM-DD').
*/ 
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


/*
Descripción: Consultar y contar la población de comensales (hombres y mujeres) en un comedor específico en una fecha dada.
Parámetros de Entrada:
-- - @NombreComedor: Nombre del comedor para el cual se desean consultar las respuestas de encuestas.
-- - @Fecha: Fecha para la cual se desea consultar la asistencia (formato 'YYYY-MM-DD').
*/ 
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


/*
Descripción: Consultar y contar la asistencia histórica de comensales a un comedor específico.
Parámetros de Entrada:
-- - @NombreComedor: Nombre del comedor para el cual se desean consultar las respuestas de encuestas.
*/ 
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


/*
Descripción: Consultar los comensales que han recibido raciones donadas en un comedor específico.
Parámetros de Entrada:
-- - @NombreComedor: Nombre del comedor para el cual se desean consultar las respuestas de encuestas.
*/ 
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


/*
Descripción: Consultar las incidencias registradas en los comedores en una fecha específica.
Parámetros de Entrada:
-- - @Fecha: Fecha para la cual se desean consultar las incidencias (formato 'YYYY-MM-DD').
*/ 
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


/*
Descripción: Verificar el inicio de sesión de un empleado encargado.
-- Parámetros de Entrada
-- - @NombreUsuario: Nombre de usuario del empleado que intenta iniciar sesión.
-- - @Contraseña: Contraseña proporcionada por el empleado para iniciar sesión.

-- Parámetros de Salida
-- - @Exito: Valor de bit que indica si el inicio de sesión fue exitoso (1) o no (0).
*/
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


/*
Descripción: Consultar el nombre de todas las condiciones registradas en la base de datos.
*/
CREATE OR ALTER PROCEDURE PROC_CCondicion
AS
BEGIN
	SELECT Nombre
	FROM Condicion
END;
GO


/*
Descripción: Generar un resumen de estadísticas de un comedor en una fecha específica.
-- Parámetros de Entrada
-- - @NombreComedor: Nombre del comedor para el cual se desean obtener estadísticas.
-- - @Fecha: Fecha para la cual se desean obtener estadísticas (formato 'YYYY-MM-DD').
*/
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


/*
Descripción: Consultar el menú de un comedor en una fecha específica.
-- Parámetros de Entrada
-- - @NombreComedor: Nombre del comedor para el cual se desean obtener estadísticas.
-- - @Fecha: Fecha para la cual se desean obtener estadísticas (formato 'YYYY-MM-DD').
*/
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


/*
Descripción: Consultar el nombre de los comedores asociados a empleados.
*/
CREATE OR ALTER PROCEDURE PROC_CNombresCom
AS
BEGIN
	SELECT Comedor.Nombre
	FROM Empleado
	JOIN Comedor ON Empleado.IDEmpleado = Comedor.IDEmpleado
END;
GO


/*
Descripción: Consultar el estado del comedor a partir de su nombre.
-- Parámetros de Entrada
-- - @NombreComedor: Nombre del comedor del cual se desea consultar el estado.
*/
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


/*
Descripción: Actualizar la información de un empleado en la base de datos.
-- Parámetros de Entrada
-- - @IDEmpleado: ID del empleado que se desea actualizar.
-- - @Nombre: Nuevo nombre del empleado.
-- - @ApellidoP: Nuevo apellido paterno del empleado.
-- - @ApellidoM: Nuevo apellido materno del empleado.
-- - @FechaNacim: Nueva fecha de nacimiento del empleado.
-- - @DescSexo: Nueva descripción del sexo del empleado.
-- - @Correo: Nuevo correo del empleado.
-- - @NombreUsuario: Nuevo nombre de usuario del empleado.
*/
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


/*
Descripción: Actualizar la contraseña de un empleado en la base de datos.
-- Parámetros de Entrada
-- - @IDEmpleado: ID del empleado cuya contraseña se desea actualizar.
-- - @Contraseña: Nueva contraseña del empleado.
*/
CREATE OR ALTER PROCEDURE PROC_AContraEmp
@IDEmpleado AS INT, @Contraseña AS VARCHAR(96)
AS
BEGIN
	UPDATE Empleado
	SET Contraseña = @Contraseña
	WHERE IDEmpleado = @IDEmpleado
END;
GO


/*
Descripción: Actualizar la información de un comedor en la base de datos.
-- Parámetros de Entrada
-- - @IDComedor: ID del comedor que se desea actualizar.
-- - @CorreoEmpleado: Nuevo correo del empleado encargado del comedor.
-- - @NombreEstadoC: Nuevo nombre del estado del comedor.
-- - @Nombre: Nuevo nombre del comedor.
-- - @Capacidad: Nueva capacidad del comedor.
-- - @Direccion: Nueva dirección del comedor.
-- - @Telefono: Nuevo número de teléfono del comedor.
*/
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


/*
Descripción: Actualizar el estado de un comedor en la base de datos.
-- Parámetros de Entrada
-- - @NombreComedor: Nombre del comedor cuyo estado se desea actualizar.
-- - @NombreEstadoC: Nuevo nombre del estado del comedor.
*/
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


/*
Descripción: Eliminar un empleado de la base de datos por su nombre de usuario.
-- Parámetros de Entrada
-- - @NombreUsuario: Nombre de usuario del empleado que se desea eliminar.
*/
CREATE OR ALTER PROCEDURE PROC_BEmpleado
@NombreUsuario AS VARCHAR(40)
AS
BEGIN
	DECLARE @EmpleadoBusq AS INT;

	SELECT @EmpleadoBusq = (SELECT IDEmpleado FROM Empleado WHERE NombreUsuario LIKE @NombreUsuario);
	
	DELETE FROM Empleado WHERE IDEmpleado = @EmpleadoBusq
END;
GO
