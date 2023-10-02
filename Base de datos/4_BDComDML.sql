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

-- Empleados
INSERT INTO Empleado VALUES (1, 'Luis Adrián', 'Abarca', 'Gómez', 1985, 'abarca.gomez.luis@comedoresdif.com', 'AbarcaLuis', 'Contra123');
INSERT INTO Empleado VALUES (1, 'Gerardo', 'Ríos', 'Mejía', 1987, 'gerry.rios@comedoresdif.com', 'RiosGerardo', 'ComedorST');
INSERT INTO Empleado VALUES (1, 'Benny', 'Sánchez', 'González', 1990, 'benny_gs@comedoresdif.com', 'SanchezBenny', 'ComedorCM');
INSERT INTO Empleado VALUES (1, 'Ángel', 'Márquez', 'Curiel', 1989, 'angeliu.marqcu@comedoresdif.com', 'MarquezAngel', 'ComedorMM');
INSERT INTO Empleado VALUES (1, 'José Ricardo', 'Moreno', 'Tahuilan', 1988, 'pepe.moreno@comedoresdif.com', 'MorenoJose', 'ComedorCG');
INSERT INTO Empleado VALUES (1, 'Martín', 'Díaz', 'Suárez', 1983, 'martin.suarez@comedoresdif.com', 'MartinDiaz', 'APassword12');

INSERT INTO Empleado VALUES (2, 'Juan Carlos', 'Carro', 'Cruz', 1989, 'carro.cruz@comedoresdif.com', 'CarroJuan', 'Password123');
INSERT INTO Empleado VALUES (2, 'Maria', 'Espinoza', 'Navarro', 1981, 'espinoza.navarro@comedoresdif.com', 'EspinozaMaria', '1234567890');
INSERT INTO Empleado VALUES (2, 'Laura', 'Fernandez', 'Chavez', 1991, 'lfrnandez.chvz@comedoresdif.com', 'FernandezLaura', 'ComedorQI');
INSERT INTO Empleado VALUES (2, 'Armando', 'Torres', 'Índigo', 1985, 'torres.indigo@comedoresdif.com', 'TorresArmando', 'ComedorCR');
INSERT INTO Empleado VALUES (2, 'Elizabeth', 'Lozano', 'Arias', 1984, 'lozano.arias@comedoresdif.com', 'ElizaLozano', 'It26531');
INSERT INTO Empleado VALUES (2, 'Emmanuel', 'Velasco', 'Vega', 1995, 'velasco.vega@comedoresdif.com', 'EmmaVelasco', 'CieloqweRa');
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
INSERT INTO Incidencias VALUES (1, 'Apertura tardía', 'Encargado de llaves tuvo un problema', '2023-09-20', '13:35:12')

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
INSERT INTO Asistencia VALUES (1, 1, 2, 1, '2023-09-17', '17:25:32');
INSERT INTO Asistencia VALUES (1, 2, 1, 1, '2023-09-17', '17:25:32');
INSERT INTO Asistencia VALUES (1, 3, 2, 1, '2023-09-19', '14:15:55');
INSERT INTO Asistencia VALUES (1, 10, 1, 1, '2023-09-17', '13:01:22');
INSERT INTO Asistencia VALUES (2, 4, 1, 1, '2023-09-16', '14:53:13');
INSERT INTO Asistencia VALUES (2, 7, 2, 1, '2023-09-17', '13:13:22');
INSERT INTO Asistencia VALUES (2, 4, 1, 1, '2023-09-17', '14:33:42');
INSERT INTO Asistencia VALUES (2, 5, 1, 1, '2023-09-17', '13:14:32');
INSERT INTO Asistencia VALUES (2, 5, 2, 1, '2023-09-20', '15:23:12');
INSERT INTO Asistencia VALUES (3, 6, 1, 1, '2023-09-17', '14:12:21');
INSERT INTO Asistencia VALUES (3, 7, 1, 1, '2023-09-18', '15:42:42');
INSERT INTO Asistencia VALUES (3, 6, 2, 1, '2023-09-18', '12:13:52');
INSERT INTO Asistencia VALUES (4, 11, 1, 1, '2023-09-17', '13:01:22');
INSERT INTO Asistencia VALUES (4, 8, 1, 1, '2023-09-17', '15:12:03');
INSERT INTO Asistencia VALUES (4, 9, 1, 1, '2023-09-17', '15:32:12');
INSERT INTO Asistencia VALUES (4, 9, 2, 1, '2023-09-21', '16:33:32');
GO

