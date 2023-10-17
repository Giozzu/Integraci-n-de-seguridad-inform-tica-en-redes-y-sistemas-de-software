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

-- Catálogo de Condiciones para los comensales 
INSERT INTO Condicion VALUES ('No Aplica');
INSERT INTO Condicion VALUES ('Menor a 5 años');
INSERT INTO Condicion VALUES ('Mayor a 65 años');
INSERT INTO Condicion VALUES ('Embarazada');
INSERT INTO Condicion VALUES ('Persona Sorda');
INSERT INTO Condicion VALUES ('Persona Ciega');
INSERT INTO Condicion VALUES ('Enfermedad Crónica');
INSERT INTO Condicion VALUES ('Discapscidad Física');
--INSERT INTO Condicion VALUES ('Malnutrición')
GO

-- *Catálogo para los Roles de un empleado
INSERT INTO Rol VALUES ('Supervisor');
INSERT INTO Rol VALUES ('Encargado');
GO

-- Catálogo para las preguntas
INSERT INTO Pregunta VALUES ('Califica la limpieza del comedor');
INSERT INTO Pregunta VALUES ('Califica la calidad de la comida');
INSERT INTO Pregunta VALUES ('Califica el servicio del comedor');
GO

/*
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
*/
--/*
-- Empleados
INSERT INTO Empleado VALUES (1, 'Héctor', 'Sánchez', 'González', 1990, 1, 'benny_gs@comedoresdif.com', 'SanchezBenny', '12345');
INSERT INTO Empleado VALUES (1, 'Luis Adrián', 'Abarca', 'Gómez', 1985, 1, 'abarca.gomez.luis@comedoresdif.com', 'AbarcaLuis', 'Contra123');
INSERT INTO Empleado VALUES (1, 'Gerardo', 'Ríos', 'Mejía', 1987, 1, 'gerry.rios@comedoresdif.com', 'RiosGerardo', 'ComedorST');
INSERT INTO Empleado VALUES (1, 'Ángel', 'Márquez', 'Curiel', 1989, 1, 'angeliu.marqcu@comedoresdif.com', 'MarquezAngel', 'ComedorMM');
INSERT INTO Empleado VALUES (1, 'José Ricardo', 'Moreno', 'Tahuilan', 1988, 1, 'pepe.moreno@comedoresdif.com', 'MorenoJose', 'ComedorCG');
INSERT INTO Empleado VALUES (1, 'Martín', 'Díaz', 'Suárez', 1983, 1, 'martin.suarez@comedoresdif.com', 'MartinDiaz', 'APassword12');

--INSERT INTO Empleado VALUES (2, 'Felisa', 'López', 'Martínez', 1989, 2, 'lopez_Feli@comedoresdif.com', 'LopezFelisa', 'pwd');
INSERT INTO Empleado VALUES (2, 'Felisa', 'López', 'Martínez', 1989, 2, 'LopezFeli@comedoresdif.com', 'Lo', 'pwd');
INSERT INTO Empleado VALUES (2, 'Abad ', 'Monroy ', 'Mendoza', 1981, 1, 'MonroyAbad@comedoresdif.com', 'MonroyAbad', '1234567890');
INSERT INTO Empleado VALUES (2, 'Eva María', 'Rodríguez ', 'Mosqueda', 1981, 2, 'RodrigEva@comedoresdif.com', 'RodrigzEva', 'Comedor');
INSERT INTO Empleado VALUES (2, 'Silvia', 'Sanabria', 'Ortega', 1985, 2, 'SanabriaSilv@comedoresdif.com', 'SanabriaSilvia', 'ComedorMJ');
INSERT INTO Empleado VALUES (2, 'David', 'Valdivia', 'Rodriguez', 1984, 1, 'ValdivDavid@comedoresdif.com', 'ValdiviaDavid', 'It231');
INSERT INTO Empleado VALUES (2, 'Lidia Valentina', 'Mendoza', 'Olivares', 1990, 2, 'MendozaLidia@comedoresdif.com', 'MendozaLidia', 'CieweRa');
INSERT INTO Empleado VALUES (2, 'Concepción', 'Martínez', 'Fernández', 1986, 2, 'MartnzConcep@comedoresdif.com', 'MartinezConz', 'UnaContra');
INSERT INTO Empleado VALUES (2, 'Tayde Martina', 'Pérez', 'Pérez', 1982, 2, 'PerezTayde@comedoresdif.com', 'PerezTayde', 'coPaordfv');
INSERT INTO Empleado VALUES (2, 'Liliana', 'Velez', 'Suárez', 1989, 2, 'VelezLiliana@comedoresdif.com', 'VelezLiliana', 'zxcvb');
INSERT INTO Empleado VALUES (2, 'María del Carmen', 'Castro', 'García', 1984, 2, 'CastroMaria@comedoresdif.com', 'CastroMaria', 'qwerrty');
INSERT INTO Empleado VALUES (2, 'Karla Aide', 'Rosas', 'Ponce', 1983, 2, 'RosasKarla@comedoresdif.com', 'RosasKarla', 'ghjkl');
INSERT INTO Empleado VALUES (2, 'José Manuel', 'Peralta', 'Tiol', 1989, 1, 'PeraltaJose@comedoresdif.com', 'PeraltaJose', 'plmokn');
INSERT INTO Empleado VALUES (2, 'Luisa', 'Barrera', 'Barrera', 1983, 2, 'BarreraLuisa@comedoresdif.com', 'BarreraLuisa', 'jhgfdds');
INSERT INTO Empleado VALUES (2, 'Asunción', 'Huertas', 'Vidal', 1986, 2, 'HuertasAsunc@comedoresdif.com', 'HuertasAsun', 'tyuio');
INSERT INTO Empleado VALUES (2, 'Leslie Magdalena', 'López', 'Bustos', 1985, 2, 'LopezLeslie@comedoresdif.com', 'LopezLeslie', 'yuiop');
INSERT INTO Empleado VALUES (2, 'Cristina', 'Fernández', 'Parada', 1982, 2, 'FerndzCristi@comedoresdif.com', 'FerndezCristi', 'xcvbn');
INSERT INTO Empleado VALUES (2, 'Beatriz', 'Gómez', 'Martínez', 1986, 2, 'GomezBeatriz@comedoresdif.com', 'GomezBeatriz', 'asddfg');
INSERT INTO Empleado VALUES (2, 'Maria Juana', 'Cano', 'Vargas', 1987, 2, 'CanoMaria@comedoresdif.com', 'CanoMaria', 'gbhnjm');
INSERT INTO Empleado VALUES (2, 'Juana', 'Aguilar', 'Monroy', 1988, 2, 'AguilarJuana@comedoresdif.com', 'AguilarJuana', 'mnbvcxz');
INSERT INTO Empleado VALUES (2, 'Margarita Paula', 'Monterrosas', 'Sánchez', 1983, 2, 'MonterrosasMar@comedoresdif.com', 'MonterrosasMarg', 'rtyuiop');
INSERT INTO Empleado VALUES (2, 'Rosa María', 'Piña', 'Tovar', 1985, 2, 'PiñaRosa@comedoresdif.com', 'PiñaRosa', '1234ty');
INSERT INTO Empleado VALUES (2, 'Griselda', 'Iglesias', 'González', 1985, 2, 'IglesiasGris@comedoresdif.com', 'IglesiasGris', '8907uy');
INSERT INTO Empleado VALUES (2, 'Giovanna', 'Padrón', 'Calvillo', 1981, 2, 'PadronGiovanna@comedoresdif.com', 'PadronGiovanna', 'sdf2345');
INSERT INTO Empleado VALUES (2, 'María de los Angeles', 'Avila', 'Huerta', 1988, 2, 'AvilaMaria@comedoresdif.com', 'AvilaAngeles', '98765tre');
INSERT INTO Empleado VALUES (2, 'Laura', 'Patiño', 'Serratos', 1987, 2, 'PatiñoLaura@comedoresdif.com', 'PatiñoLaura', 'xcv456');
INSERT INTO Empleado VALUES (2, 'Blanca Patricia', 'Martinez', 'Olayo', 1984, 2, 'MartnzBlanca@comedoresdif.com', 'MartinezBlanca', 'kjh876a');
INSERT INTO Empleado VALUES (2, 'Raymundo', 'Villanueva', 'Santillán', 1985, 1, 'VillanuevaRaymundo@comedoresdif.com', 'VillanuevaRay', '3456sklz');
INSERT INTO Empleado VALUES (2, 'Yessica Iskra', 'Escalante', 'Barragán', 1981, 2, 'EscalanteYessica@comedoresdif.com', 'EscalanteYess', 'sdfg6789');
INSERT INTO Empleado VALUES (2, 'Emilia Yasmin', 'Figueroa', 'Jose', 1980, 2, 'FigueroaEmilia@comedoresdif.com', 'FigueroaEmilia', 'zxcv23456');
INSERT INTO Empleado VALUES (2, 'Rosa Maria', 'Fierros', 'Comparan', 1989, 2, 'FierrosRosa@comedoresdif.coRosam', 'FierrosRosa', 'lmkn976w');
INSERT INTO Empleado VALUES (2, 'Mariela', 'Pablo', 'Florentino', 1979, 2, '@comedoresdif.com', 'PabloMariela', 'xcvbnm32');
INSERT INTO Empleado VALUES (2, 'Claudia', '@comedoresdif.com', 'Castillo', 1990, 2, 'CastilloClaudia@comedoresdif.com', 'CastilloClaudia', '5678vcxrtgh');
INSERT INTO Empleado VALUES (2, 'Graciela', 'Ruiz', 'Vaca', 1986, 2, 'RuizGraciela@comedoresdif.com', 'RuizGraciela', 'contraseñaskfj');
INSERT INTO Empleado VALUES (2, 'Nancy', 'Rivera', 'Trejo', 1985, 2, 'RiveraNancy@comedoresdif.com', 'RiveraNancy', 'cvbnm75645');
INSERT INTO Empleado VALUES (2, 'Maria del Carmen', 'Ramírez', 'González', 1983, 2, 'RamirezMaria@comedoresdif.com', 'RamirezMaria', 'oiu87654xcv');
INSERT INTO Empleado VALUES (2, 'María Dolores', 'Sarabía', 'Mendoza', 1985, 2, 'SarabiaMaria@comedoresdif.com', 'SarabiaMaria', 'vbnmefghre45');
INSERT INTO Empleado VALUES (2, 'Mónica', 'Juana', 'Cruz', 1982, 2, 'JuanaMonica@comedoresdif.com', 'JuanaMonica', 'fg567687564g53f');
GO

-- Comedores
-- IDEmpleado, IDEstado, Nombre, Capacidad, Direccion, Telefono
INSERT INTO Comedor VALUES (7, 1, '5 de Mayo', 55, 'Calle Porfirio Díaz #27', '5539747974');
INSERT INTO Comedor VALUES (8, 1, 'México 86', 65, 'Calle Italia # 53', '5634575638');
INSERT INTO Comedor VALUES (9, 1, 'Lomas de Monte María', 85, 'Calle Monte Real Mz 406 LT 11', '5581973756');
INSERT INTO Comedor VALUES (10, 1, 'Margarita Maza de Juárez', 45, 'Calle Francisco Javier Mina #12', '5524842220');
INSERT INTO Comedor VALUES (11, 1, 'Cerro Grande', 60, 'Calle Teotihuacan #15', '5572118520 ');
INSERT INTO Comedor VALUES (12, 1, 'Amp Peñitas', 65, 'Cda. Gardenias #3', '5620218500');
INSERT INTO Comedor VALUES (13, 1, 'San José el Jaral 2', 75, 'Calle Jazmín #22', '5560294795');
INSERT INTO Comedor VALUES (14, 1, 'Ampl. Emiliano Zapata', 55, 'Av. Ejército Mexicano s/n', '5626784747');
INSERT INTO Comedor VALUES (15, 1, 'Lomas de Atizapán', 50, 'Central. Av. Ruiz Cortines esq. Acambay', '5569095267');
INSERT INTO Comedor VALUES (16, 1, 'Adolfo López Mateos', 55, 'Privada Zacatecas no. 6', '5610215822');
INSERT INTO Comedor VALUES (17, 1, 'Hogares de Atizapán', 55, 'Hogares. Retorno de la Tranquilidad No. 8A', '5635834925');
INSERT INTO Comedor VALUES (18, 1, 'Rinconada Bonfil', 40, 'Calle Rosas MZ 4 Lt 15', '5532297233');
INSERT INTO Comedor VALUES (19, 1, 'San Juan Bosco', 45, 'Calle Profesor Roberto Barrio No. 2', '5534845591');
INSERT INTO Comedor VALUES (20, 1, 'Peñitas', 50, 'Mirador 1 #100 Colonia las peñitas', '5627424245');
INSERT INTO Comedor VALUES (21, 1, 'Rancho Castro', 60, 'Calle del Puente s/n Rancho salón de usos múltiplos', '5537141425');
INSERT INTO Comedor VALUES (22, 1, 'Amp villa de las Palmas', 45, 'Villas de las palmas Calle avena Mz. 5 Lt. 12', '5521499089');
INSERT INTO Comedor VALUES (23, 1, 'Col. UAM', 75, 'UAM Calle Ingenieria Industrial Mz 24 Lt 45', '5618278539');
INSERT INTO Comedor VALUES (24, 1, 'Bosques de Ixtacala', 75, 'Cerrada Sauces Mz 12 Lt 13- C #6', '5521797660');
INSERT INTO Comedor VALUES (25, 1, 'Lomas de Tepalcapa', 65, 'Calle seis # 14', '5544836519');
INSERT INTO Comedor VALUES (26, 1, 'Villa de las Torres', 55, 'Calle Villa Alba Mza. 17 lote 9, esquina Bicentenario', '5535771343');
INSERT INTO Comedor VALUES (27, 1, 'Prof. Cristobal Higuera', 50, 'Calle Sandía # 24', '5528499927');
INSERT INTO Comedor VALUES (28, 1, 'Lomas de Guadalupe', 50, 'Calle Vicente Guerrero Número 2', '5565042802');
INSERT INTO Comedor VALUES (29, 1, 'Lázaro Cardenas', 65, 'Calle Chihuahua 151-A', '5529435985');
INSERT INTO Comedor VALUES (30, 1, 'El Chaparral', 65, 'Calle Túcan # 48', '5539313519');
INSERT INTO Comedor VALUES (31, 1, 'Primero de Septiembre', 55, 'Calle Belisario Dominguez # 44', '5568622143');
INSERT INTO Comedor VALUES (32, 1, 'Las Aguilas', 45, 'Pavo Real # 18', '5628103085');
INSERT INTO Comedor VALUES (33, 1, 'El Cerrito', 50, 'Paseo Buenavista # 1', '5513614569');
INSERT INTO Comedor VALUES (34, 1, 'Villas de la Hacienda', 40, 'Calle de la Chaparreras # 5', '5543463066');
INSERT INTO Comedor VALUES (35, 1, 'San Juan Ixtacala P/N 1', 60, 'Loma San Juan 194', '5540488294');
INSERT INTO Comedor VALUES (36, 1, 'Prados Ixtcala 2da secc', 65, 'Clavel no.13 Mz 13 Lt 7', '5620318471');
INSERT INTO Comedor VALUES (37, 1, 'Villa Jardin', 75, 'Cda . Francisco Villa S/N', '5560212020');
INSERT INTO Comedor VALUES (38, 1, 'Amp Cristobal Higuera', 85, 'Calle Aldama #17', '5611085980');
INSERT INTO Comedor VALUES (39, 1, 'Amp. Adolfo López Mateos', 55, 'Calle Leon #1 esquina Coatzacoalcos', '5619049313');
INSERT INTO Comedor VALUES (40, 1, 'Lomas de San Miguel', 65, 'Jacarandas #5', '5586145481');
INSERT INTO Comedor VALUES (41, 1, 'San Juan Ixtacala P/N 2', 75, 'Boulevar Ignacio Zaragoza , Loma Alta #82', '5531434220');
INSERT INTO Comedor VALUES (42, 1, 'Los Olivos', 85, 'Calle Mérida numero 10', '5634167990');
INSERT INTO Comedor VALUES (43, 1, 'Tierra de en medio', 50, 'Hacienda de la Flor #14', '5527014162');
GO
--*/

-- Menú
INSERT INTO Menu VALUES (1, '', '', '', '', '', 13.00, '');
INSERT INTO Menu VALUES (2, '', '', '', '', '', 13.00, '');
INSERT INTO Menu VALUES (3, '', '', '', '', '', 13.00, '');
INSERT INTO Menu VALUES (4, '', '', '', '', '', 13.00, '');
INSERT INTO Menu VALUES (5, '', '', '', '', '', 13.00, '');
INSERT INTO Menu VALUES (6, '', '', '', '', '', 13.00, '');
INSERT INTO Menu VALUES (7, '', '', '', '', '', 13.00, '');
INSERT INTO Menu VALUES (8, '', '', '', '', '', 13.00, '');
INSERT INTO Menu VALUES (9, '', '', '', '', '', 13.00, '');
INSERT INTO Menu VALUES (10, '', '', '', '', '', 13.00, '');
INSERT INTO Menu VALUES (11, '', '', '', '', '', 13.00, '');
INSERT INTO Menu VALUES (12, '', '', '', '', '', 13.00, '');
INSERT INTO Menu VALUES (13, '', '', '', '', '', 13.00, '');
INSERT INTO Menu VALUES (14, '', '', '', '', '', 13.00, '');
INSERT INTO Menu VALUES (15, '', '', '', '', '', 13.00, '');
INSERT INTO Menu VALUES (16, '', '', '', '', '', 13.00, '');
INSERT INTO Menu VALUES (17, '', '', '', '', '', 13.00, '');
INSERT INTO Menu VALUES (18, '', '', '', '', '', 13.00, '');
INSERT INTO Menu VALUES (19, '', '', '', '', '', 13.00, '');
INSERT INTO Menu VALUES (20, '', '', '', '', '', 13.00, '');
INSERT INTO Menu VALUES (21, '', '', '', '', '', 13.00, '');
INSERT INTO Menu VALUES (22, '', '', '', '', '', 13.00, '');
INSERT INTO Menu VALUES (23, '', '', '', '', '', 13.00, '');
INSERT INTO Menu VALUES (24, '', '', '', '', '', 13.00, '');
INSERT INTO Menu VALUES (25, '', '', '', '', '', 13.00, '');
INSERT INTO Menu VALUES (26, '', '', '', '', '', 13.00, '');
INSERT INTO Menu VALUES (27, '', '', '', '', '', 13.00, '');
INSERT INTO Menu VALUES (28, '', '', '', '', '', 13.00, '');
INSERT INTO Menu VALUES (29, '', '', '', '', '', 13.00, '');
INSERT INTO Menu VALUES (30, '', '', '', '', '', 13.00, '');
INSERT INTO Menu VALUES (31, '', '', '', '', '', 13.00, '');
INSERT INTO Menu VALUES (32, '', '', '', '', '', 13.00, '');
INSERT INTO Menu VALUES (33, '', '', '', '', '', 13.00, '');
INSERT INTO Menu VALUES (34, '', '', '', '', '', 13.00, '');
INSERT INTO Menu VALUES (35, '', '', '', '', '', 13.00, '');
INSERT INTO Menu VALUES (36, '', '', '', '', '', 13.00, '');
INSERT INTO Menu VALUES (37, '', '', '', '', '', 13.00, '');

/*
INSERT INTO Menu VALUES (1, 'Sopa de caracol', 'Enchiladas', 'Tortillas', 'Agua de Limón', 'Chiles en vinagre', 13.00, '2023-09-12');
INSERT INTO Menu VALUES (1, 'Arroz rojo', 'Nopales con Cilantro', 'Tortillas', 'Agua simple', 'Fijoles', 13.00, '2023-09-13');
INSERT INTO Menu VALUES (2, 'Arroz blanco', 'Torta de papa', 'Pan bolillo', 'Agua de Jamaica', 'Salsa roja',  13.00, '2023-09-12');
INSERT INTO Menu VALUES (2, '', 'Caldo de Pollo con Verduras', 'Tortillas', 'Agua simple', '', 13.00, '2023-09-13');
INSERT INTO Menu VALUES (3, 'Sopa de fideos', 'Bisteces con hígado cebollado', 'Pan salado', 'Agua de Horchata', 'Frijoles', 13.00, '2023-09-12');
INSERT INTO Menu VALUES (3, 'Arroz blanco', 'Chicharron en salsa', 'Pan bolillo', 'Agua de Tamarindo', 'Salsa verde', 13.00, '2023-09-13');
INSERT INTO Menu VALUES (4, 'Sopa de pollo', 'Arrachera', 'Tortillas', 'Agua de sandía', 'Frijoles', 13.00, '2023-09-12');
INSERT INTO Menu VALUES (4, 'Arroz rojo', 'Albondigas', 'Tortillas', 'Agua simple', 'Chiles en vinagre', 13.00, '2023-09-13');
GO
*/

-- Incidencias
INSERT INTO Incidencia VALUES (1, 'Apertura tardía', 'Encargado de llaves tuvo un problema', '2023-10-17');
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

INSERT INTO Asistencia VALUES (1, 1, 2, 1, '2023-10-17');
INSERT INTO Asistencia VALUES (1, 2, 1, 1, '2023-10-17');
INSERT INTO Asistencia VALUES (1, 3, 2, 1, '2023-10-17');
INSERT INTO Asistencia VALUES (1, 10, 1, 1, '2023-10-17');
INSERT INTO Asistencia VALUES (2, 4, 1, 1, '2023-10-17');
INSERT INTO Asistencia VALUES (2, 7, 2, 1, '2023-10-17');
INSERT INTO Asistencia VALUES (2, 4, 1, 1, '2023-10-17');
INSERT INTO Asistencia VALUES (2, 5, 1, 1, '2023-10-17');
INSERT INTO Asistencia VALUES (2, 5, 2, 1, '2023-10-17');
INSERT INTO Asistencia VALUES (3, 6, 1, 1, '2023-10-17');
INSERT INTO Asistencia VALUES (3, 7, 1, 1, '2023-10-17');
INSERT INTO Asistencia VALUES (3, 6, 2, 1, '2023-10-17');
INSERT INTO Asistencia VALUES (4, 11, 1, 1, '2023-10-17');
INSERT INTO Asistencia VALUES (4, 8, 1, 1, '2023-10-17');
INSERT INTO Asistencia VALUES (4, 9, 1, 1, '2023-10-17');
INSERT INTO Asistencia VALUES (4, 9, 2, 1, '2023-10-17');

INSERT INTO Asistencia VALUES (5, 10, 1, 1, '2023-10-17');
INSERT INTO Asistencia VALUES (5, 11, 1, 1, '2023-10-17');
INSERT INTO Asistencia VALUES (5, 2, 1, 1, '2023-10-17');
INSERT INTO Asistencia VALUES (5, 1, 2, 1, '2023-10-17');
INSERT INTO Asistencia VALUES (5, 3, 2, 1, '2023-10-17');
INSERT INTO Asistencia VALUES (5, 4, 1, 1, '2023-10-17');

INSERT INTO Asistencia VALUES (6, 6, 1, 1, '2023-10-17');
INSERT INTO Asistencia VALUES (6, 7, 1, 1, '2023-10-17');
INSERT INTO Asistencia VALUES (6, 8, 1, 1, '2023-10-17');
GO


-- IDComedor, IDComensal, IDTipoRacion, Raciones, Fecha