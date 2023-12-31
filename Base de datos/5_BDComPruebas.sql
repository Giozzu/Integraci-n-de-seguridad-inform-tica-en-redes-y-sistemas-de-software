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

EXECUTE PROC_IComedor 'suarez.vidal@comedoresdif.com', 'Abierto', 'Lago de Guadalupe', 69, 'DireccionGenericaLG', '55456789081';
GO

-- APP VOL/ENC --
EXECUTE PROC_AMenu '5 de Mayo', 'SopE', 'MilanesasEEE', 'Pan EEE', 'EE de Limón', 'EE', '2023-09-18';
GO

EXECUTE PROC_CVerMenu '5 de Mayo', '2023-09-18';
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
EXECUTE PROC_IEncuesta 'Lago de Guadalupe', 'Califica la limpieza del comedor', 'Una comida bien servida', 8, '2023-10-04'
EXECUTE PROC_IEncuesta 'Lago de Guadalupe', 'Califica la calidad de la comida', 'Limpio, pero podía mejorar', 7, '2023-10-04'
EXECUTE PROC_IEncuesta 'Lago de Guadalupe', 'Califica el servicio del comedor', 'Muy bien servicio', 9, '2023-10-04'
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

EXECUTE PROC_CEncuesta '5 de Mayo', '2023-10-01';
GO

--<Sección de "Vista por comedor">
EXECUTE PROC_CAsisComensales '5 de Mayo', '2023-09-17';
GO

EXECUTE PROC_CPoblaCome '5 de Mayo', '2023-09-17';
GO

EXECUTE PROC_CHistAsisComen '5 de Mayo';
GO

EXECUTE PROC_CRacionDonada '5 de Mayo';
GO

EXECUTE PROC_CIncidencias '2023-09-20';
GO

-- APP VOL/ENC --
DECLARE @Exito1 AS BIT;
EXECUTE PROC_LoginEmpE 'Lo', 'pwd', @Exito1 OUTPUT;
SELECT @Exito1;
GO

EXECUTE PROC_CCondicion;
GO

--<Sección de "Dashboard">
EXECUTE PROC_CDashBoard '5 de Mayo', '2023-09-17';
GO

EXECUTE PROC_CDashBoardComp '5 de Mayo', '2023-09-17';
GO


-- APP COM --
EXECUTE PROC_CVerMenu '5 de Mayo', '2023-09-12';
GO

EXECUTE PROC_CIncidenciasC '5 de Mayo', '2023-09-20';
GO

EXECUTE PROC_CSuperCorreo;
GO

EXECUTE PROC_CNombresCom;
GO

EXECUTE PROC_CPreguntas;
GO

EXECUTE PROC_CEstadoCom '5 de Mayo';
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

SELECT * FROM Incidencia