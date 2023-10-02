-- PRUEBAS 

USE ComedorBD;
GO

-- SPs
--INSERTAR
-- WEB --
EXECUTE PROC_IEmpleadoS 'Fernando', 'Carrillo', 'Mateos', 1989, 'carr.fernando@comedoresdif.com', 'FerCarrillo', '456Contra123';
GO

EXECUTE PROC_IEmpleadoE 'Sofía', 'Vidal', 'Suárez',  1990, 'suarez.vidal@comedoresdif.com', 'VidalSofia', 'MyPassword';
GO

EXECUTE PROC_IComedor 'lozano.arias@comedoresdif.com', 'Abierto', 'Lago de Guadalupe', 69, 'DireccionGenericaLG', '55456789081';
GO


-- APP VOL/ENC --
EXECUTE PROC_IMenu 'Lago de Guadalupe', 'Sopa de Tortilla', 'Milanesas', 'Pan salado', 'Agua de Limón', 'Frijoles', '2023-09-17';
GO

EXECUTE PROC_IIncidencias 'Lago de Guadalupe', 'Fuga de gas', 'La cocina tuvó una fuga de gas', '2023-09-21', '13:32:21';
GO

EXECUTE PROC_IComensal 'Matias', 'Hernández', 'Aguirre', 'MHZA658912ASMNJYG9', 1999, 'Hombre', 1110;
EXECUTE PROC_ICondCom 'MHZA658912ASMNJYG9', 'No Aplica';
GO

EXECUTE PROC_IAsistenciaC 'Lago de Guadalupe', 'OCLE984565MNBVSR8', 'Pagada', 1, '2023-09-18', '12:52:12';
GO

EXECUTE PROC_IAsistenciaT 'Lago de Guadalupe', 1110, 'Donada', 1, '2023-09-17', '14:32:23';
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

EXECUTE PROC_CSexos;
GO

EXECUTE PROC_CCondicion;
GO

EXECUTE PROC_CTipoRacion;
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


--ACTUALIZAR
-- WEB --
EXECUTE PROC_AEmpleado 7, 'Juan Pedro', 'Carro', 'Cruz', 1990, 'carro.cruz@comedoresdif.com', 'PedroCarro';
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
SELECT *
FROM Comedor

SELECT *
FROM Comensal

SELECT *
FROM Menu

SELECT *
FROM Asistencia


