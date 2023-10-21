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
INSERT INTO Condicion VALUES ('Discapacidad Auditiva');
INSERT INTO Condicion VALUES ('Discapacidad Visual');
INSERT INTO Condicion VALUES ('Discapacidad Física');
INSERT INTO Condicion VALUES ('Enfermedad Crónica');
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
INSERT INTO Empleado VALUES (2, 'Abad ', 'Monroy ', 'Mendoza', 1981, 1, 'MonroyAbad@comedoresdif.com', 'MAbd', '123');
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
INSERT INTO Comedor VALUES (7, 2, '5 de Mayo', 55, 'Calle Porfirio Díaz #27', '5539747974');
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
INSERT INTO Comedor VALUES (38, 2, 'Amp Cristobal Higuera', 85, 'Calle Aldama #17', '5611085980');

INSERT INTO Comedor VALUES (39, 2, 'Amp. Adolfo López Mateos', 55, 'Calle Leon #1 esquina Coatzacoalcos', '5619049313');
INSERT INTO Comedor VALUES (40, 2, 'Lomas de San Miguel', 65, 'Jacarandas #5', '5586145481');
INSERT INTO Comedor VALUES (41, 2, 'San Juan Ixtacala P/N 2', 75, 'Boulevar Ignacio Zaragoza , Loma Alta #82', '5531434220');
INSERT INTO Comedor VALUES (42, 2, 'Los Olivos', 85, 'Calle Mérida numero 10', '5634167990');
INSERT INTO Comedor VALUES (43, 2, 'Tierra de en medio', 50, 'Hacienda de la Flor #14', '5527014162');
GO
--*/

-- Menú
INSERT INTO Menu VALUES (1, '', '', '', '', '', 13.00, '');
INSERT INTO Menu VALUES (2, 'Sopa de fideos', 'Enchiladas', 'Pan salado', 'Agua de jamaica', 'Frijoles', 13.00, '2023-10-20');
INSERT INTO Menu VALUES (3, 'Arroz blanco', 'Chicharron en salsa', 'Tortillas', 'Agua de limón', 'Chiles en vinagre', 13.00, '2023-10-20');
INSERT INTO Menu VALUES (4, 'Sopa de tortilla', 'Nopales con cilantro', 'Pan bolillo', 'Agua de limón', 'Frijoles', 13.00, '2023-10-20');
INSERT INTO Menu VALUES (5, 'Sopa de caracol', 'Bisteces con hígado cebollado', 'Tortillas', 'Agua simple', 'Salsa roja', 13.00, '2023-10-20');
INSERT INTO Menu VALUES (6, 'Caldito', 'Torta de papa', 'Pan bolillo', 'Agua de limón', 'Salsa verde', 13.00, '2023-10-20');

INSERT INTO Menu VALUES (7, 'Arroz blanco', 'Caldo de pollo', 'Tortillas', 'Agua simple', 'Salsa verde', 13.00, '2023-10-20');
INSERT INTO Menu VALUES (8, 'Sopa de fideos', 'Albondigas', 'Tortillas', 'Agua de tamarindo', 'Chiles en vinagre', 13.00, '2023-10-20');
INSERT INTO Menu VALUES (9, 'Arroz blanco', 'Arrachera', 'Tortillas', 'Agua simple', 'Frijoles', 13.00, '2023-10-20');
INSERT INTO Menu VALUES (10, 'Sopa de fideos', 'Torta de papa', 'Tortillas', 'Agua de horchata', 'Salsa verde', 13.00, '2023-10-20');
INSERT INTO Menu VALUES (11, 'Arroz rojo', 'Consomé', 'Pan bolillo', 'Agua de limón', 'Frijoles', 13.00, '2023-10-20');

INSERT INTO Menu VALUES (12, 'Sopa de jitomate', 'Arrachera', 'Tortillas', 'Agua simple', 'Salsa verde', 13.00, '2023-10-20');
INSERT INTO Menu VALUES (13, 'Sopa de caracol', 'Torta de papa', 'Tortillas', 'Agua de tamarindo', 'Chiles en vinagre', 13.00, '2023-10-20');
INSERT INTO Menu VALUES (14, 'Arroz blanco', 'Caldo de pollo', 'Tortillas', 'Agua simple', 'Salsa roja', 13.00, '2023-10-20');
INSERT INTO Menu VALUES (15, 'Sopa de fideos', 'Arrachera', 'Pan bolillo', 'Agua de limón', 'Frijoles', 13.00, '2023-10-20');
INSERT INTO Menu VALUES (16, 'Sopa de caracol', 'Tacos dorados', 'Tortillas', 'Agua de tamarindo', 'Chiles en vinagre', 13.00, '2023-10-20');

INSERT INTO Menu VALUES (17, 'Arroz rojo', 'Tacos dorados', 'Pan bolillo', 'Agua de horchata', 'Frijoles', 13.00, '2023-10-20');
INSERT INTO Menu VALUES (18, 'Sopa de jitomate', 'Chicharron en salsa', 'Pan bolillo', 'Agua de limón', 'Salsa roja', 13.00, '2023-10-20');
INSERT INTO Menu VALUES (19, 'Sopa de fideos', 'Enchiladas', 'Pan bolillo', 'Agua de horchata', 'Salsa verde', 13.00, '2023-10-20');
INSERT INTO Menu VALUES (20, 'Arroz blanco', 'Albondigas', 'Pan salado', 'Agua de tamarindo', 'Chiles en vinagre', 13.00, '2023-10-20');
INSERT INTO Menu VALUES (21, 'Arroz blanco', 'Consomé', 'Pan bolillo', 'Agua de horchata', 'Salsa roja', 13.00, '2023-10-20');

INSERT INTO Menu VALUES (22, 'Sopa de jitomate', 'Enchiladas', 'Pan salado', 'Agua de tamarindo', 'Frijoles', 13.00, '2023-10-20');
INSERT INTO Menu VALUES (23, 'Sopa miso', 'Albondigas', 'Pan salado', 'Agua de horchata', 'Chiles en vinagre', 13.00, '2023-10-20');
INSERT INTO Menu VALUES (24, 'Arroz blanco', 'Tacos dorados', 'Pan salado', 'Agua simple', 'Frijoles', 13.00, '2023-10-20');
INSERT INTO Menu VALUES (25, 'Sopa miso', 'Consomé', 'Pan bolillo', 'Agua de horchata', 'Salsa roja', 13.00, '2023-10-20');
INSERT INTO Menu VALUES (26, 'Arroz blanco', 'Enchiladas', 'Tortillas', 'Agua simple', 'Salsa verde', 13.00, '2023-10-20');
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


-- Incidencias
INSERT INTO Incidencia VALUES (28, 'Se lastimó un voluntario', 'Se quemó la mano', '2023-10-20');
INSERT INTO Incidencia VALUES (29, 'Comida', 'Se cayó una cacerola de comida', '2023-10-20');
INSERT INTO Incidencia VALUES (30, 'Falta de voluntarios', 'Solo somos 5 voluntarios', '2023-10-20');
INSERT INTO Incidencia VALUES (31, 'Material', 'Falta mucho material para cocinar', '2023-10-20');
INSERT INTO Incidencia VALUES (32, 'Apertura tardía', 'El dueño de la casa olvidó sus llaves', '2023-10-20');

INSERT INTO Incidencia VALUES (33, 'Apertura tardía', 'Encargado de llaves tuvo un problema', '2023-10-20');
INSERT INTO Incidencia VALUES (34, 'Fuga de gas', 'Dentro de la colonia hubo fuerte accidente', '2023-10-20');
INSERT INTO Incidencia VALUES (35, 'Dueños casa', 'No pudo prestar su casa', '2023-10-20');
INSERT INTO Incidencia VALUES (36, 'Fuga Agua', 'Problema grave con tuberías en casa', '2023-10-20');
INSERT INTO Incidencia VALUES (37, 'Calle cerrada', 'Por motivos de seguridad', '2023-10-20');
GO

-- Encuesta
INSERT INTO Encuesta VALUES (2, 1, 'Muy limpio', 5, '2023-10-20');
INSERT INTO Encuesta VALUES (2, 2, 'Buena pero puede mejorar', 3, '2023-10-20');
INSERT INTO Encuesta VALUES (2, 3, 'Me atendieron de malas', 2, '2023-10-20');
INSERT INTO Encuesta VALUES (2, 1, 'Limpio pero no ordenado', 4, '2023-10-20');
INSERT INTO Encuesta VALUES (2, 2, 'Muy salada', 2, '2023-10-20');
INSERT INTO Encuesta VALUES (2, 3, 'Servicio de calidad', 5, '2023-10-20');
INSERT INTO Encuesta VALUES (2, 1, 'Esta algo sucio', 3, '2023-10-20');
INSERT INTO Encuesta VALUES (2, 2, 'N/A', 4, '2023-10-20');
INSERT INTO Encuesta VALUES (2, 3, 'N/A', 4, '2023-10-20');

INSERT INTO Encuesta VALUES (3, 1, 'Muy limpio', 5, '2023-10-20');
INSERT INTO Encuesta VALUES (3, 2, 'Buena pero puede mejorar', 3, '2023-10-20');
INSERT INTO Encuesta VALUES (3, 3, 'Me atendieron de malas', 2, '2023-10-20');
INSERT INTO Encuesta VALUES (3, 1, 'Limpio pero no ordenado', 4, '2023-10-20');
INSERT INTO Encuesta VALUES (3, 2, 'Muy salada', 2, '2023-10-20');
INSERT INTO Encuesta VALUES (3, 3, 'Servicio de calidad', 5, '2023-10-20');
INSERT INTO Encuesta VALUES (4, 1, 'Esta algo sucio', 3, '2023-10-20');
INSERT INTO Encuesta VALUES (4, 2, 'N/A', 4, '2023-10-20');
INSERT INTO Encuesta VALUES (4, 3, 'N/A', 4, '2023-10-20');
INSERT INTO Encuesta VALUES (4, 1, 'N/A', 5, '2023-10-20');
INSERT INTO Encuesta VALUES (4, 2, 'Me sirvieron algo crudo', 1, '2023-10-20');
INSERT INTO Encuesta VALUES (4, 3, 'Buena atención', 4, '2023-10-20');

INSERT INTO Encuesta VALUES (5, 1, 'Muy limpio', 5, '2023-10-20');
INSERT INTO Encuesta VALUES (5, 2, 'Buena pero puede mejorar', 3, '2023-10-20');
INSERT INTO Encuesta VALUES (5, 3, 'Me atendieron de malas', 2, '2023-10-20');
INSERT INTO Encuesta VALUES (5, 1, 'Limpio pero no ordenado', 4, '2023-10-20');
INSERT INTO Encuesta VALUES (5, 2, 'Muy salada', 2, '2023-10-20');
INSERT INTO Encuesta VALUES (5, 3, 'Servicio de calidad', 5, '2023-10-20');
INSERT INTO Encuesta VALUES (6, 1, 'Esta algo sucio', 3, '2023-10-20');
INSERT INTO Encuesta VALUES (6, 2, 'N/A', 4, '2023-10-20');
INSERT INTO Encuesta VALUES (6, 3, 'N/A', 4, '2023-10-20');
INSERT INTO Encuesta VALUES (6, 1, 'N/A', 5, '2023-10-20');
INSERT INTO Encuesta VALUES (6, 2, 'Me sirvieron algo crudo', 1, '2023-10-20');
INSERT INTO Encuesta VALUES (6, 3, 'Buena atención', 4, '2023-10-20');

INSERT INTO Encuesta VALUES (7, 1, 'Muy limpio', 5, '2023-10-20');
INSERT INTO Encuesta VALUES (7, 2, 'Buena pero puede mejorar', 3, '2023-10-20');
INSERT INTO Encuesta VALUES (7, 3, 'Me atendieron de malas', 2, '2023-10-20');
INSERT INTO Encuesta VALUES (7, 1, 'Limpio pero no ordenado', 4, '2023-10-20');
INSERT INTO Encuesta VALUES (7, 2, 'Muy salada', 2, '2023-10-20');
INSERT INTO Encuesta VALUES (7, 3, 'Servicio de calidad', 5, '2023-10-20');
INSERT INTO Encuesta VALUES (8, 1, 'Esta algo sucio', 3, '2023-10-20');
INSERT INTO Encuesta VALUES (8, 2, 'N/A', 4, '2023-10-20');
INSERT INTO Encuesta VALUES (8, 3, 'N/A', 4, '2023-10-20');
INSERT INTO Encuesta VALUES (8, 1, 'N/A', 5, '2023-10-20');
INSERT INTO Encuesta VALUES (8, 2, 'Me sirvieron algo crudo', 1, '2023-10-20');
INSERT INTO Encuesta VALUES (8, 3, 'Buena atención', 4, '2023-10-20');

INSERT INTO Encuesta VALUES (9, 1, 'Muy limpio', 5, '2023-10-20');
INSERT INTO Encuesta VALUES (9, 2, 'Buena pero puede mejorar', 3, '2023-10-20');
INSERT INTO Encuesta VALUES (9, 3, 'Me atendieron de malas', 2, '2023-10-20');
INSERT INTO Encuesta VALUES (9, 1, 'Limpio pero no ordenado', 4, '2023-10-20');
INSERT INTO Encuesta VALUES (9, 2, 'Muy salada', 2, '2023-10-20');
INSERT INTO Encuesta VALUES (9, 3, 'Servicio de calidad', 5, '2023-10-20');
INSERT INTO Encuesta VALUES (10, 1, 'Esta algo sucio', 3, '2023-10-20');
INSERT INTO Encuesta VALUES (10, 2, 'N/A', 4, '2023-10-20');
INSERT INTO Encuesta VALUES (10, 3, 'N/A', 4, '2023-10-20');
INSERT INTO Encuesta VALUES (10, 1, 'N/A', 5, '2023-10-20');
INSERT INTO Encuesta VALUES (10, 2, 'Me sirvieron algo crudo', 1, '2023-10-20');
INSERT INTO Encuesta VALUES (10, 3, 'Buena atención', 4, '2023-10-20');

INSERT INTO Encuesta VALUES (11, 1, 'Muy limpio', 5, '2023-10-20');
INSERT INTO Encuesta VALUES (11, 2, 'Buena pero puede mejorar', 3, '2023-10-20');
INSERT INTO Encuesta VALUES (11, 3, 'Me atendieron de malas', 2, '2023-10-20');
INSERT INTO Encuesta VALUES (11, 1, 'Limpio pero no ordenado', 4, '2023-10-20');
INSERT INTO Encuesta VALUES (11, 2, 'Muy salada', 2, '2023-10-20');
INSERT INTO Encuesta VALUES (11, 3, 'Servicio de calidad', 5, '2023-10-20');
INSERT INTO Encuesta VALUES (12, 1, 'Esta algo sucio', 3, '2023-10-20');
INSERT INTO Encuesta VALUES (12, 2, 'N/A', 4, '2023-10-20');
INSERT INTO Encuesta VALUES (12, 3, 'N/A', 4, '2023-10-20');
INSERT INTO Encuesta VALUES (12, 1, 'N/A', 5, '2023-10-20');
INSERT INTO Encuesta VALUES (12, 2, 'Me sirvieron algo crudo', 1, '2023-10-20');
INSERT INTO Encuesta VALUES (12, 3, 'Buena atención', 4, '2023-10-20');

INSERT INTO Encuesta VALUES (7, 1, 'Muy limpio', 5, '2023-10-20');
INSERT INTO Encuesta VALUES (7, 2, 'Buena pero puede mejorar', 3, '2023-10-20');
INSERT INTO Encuesta VALUES (7, 3, 'Me atendieron de malas', 2, '2023-10-20');
INSERT INTO Encuesta VALUES (7, 1, 'Limpio pero no ordenado', 4, '2023-10-20');
INSERT INTO Encuesta VALUES (7, 2, 'Muy salada', 2, '2023-10-20');
INSERT INTO Encuesta VALUES (7, 3, 'Servicio de calidad', 5, '2023-10-20');
INSERT INTO Encuesta VALUES (8, 1, 'Esta algo sucio', 3, '2023-10-20');
INSERT INTO Encuesta VALUES (8, 2, 'N/A', 4, '2023-10-20');
INSERT INTO Encuesta VALUES (8, 3, 'N/A', 4, '2023-10-20');
INSERT INTO Encuesta VALUES (8, 1, 'N/A', 5, '2023-10-20');
INSERT INTO Encuesta VALUES (8, 2, 'Me sirvieron algo crudo', 1, '2023-10-20');
INSERT INTO Encuesta VALUES (8, 3, 'Buena atención', 4, '2023-10-20');
GO

-- Comensales
INSERT INTO Comensal (Nombre, ApellidoP, CURP, Token) VALUES ('Persona', 'Genérica', 'ABCD123456EFGHIJK7', 10000);
INSERT INTO Comensal VALUES ('Alfredo', 'Azamar', 'López', 'AALA031210HDFZPLA7', 2003, 1, 10100);
INSERT INTO Comensal VALUES ('Marco', 'Cortes', 'Sandoval', 'MCCS125468OIFBDXT1', 1889, 1, 10200);
INSERT INTO Comensal VALUES ('Daniel', 'Méndez', 'Ramos', 'DAMR235678QWDFGHU7', 2019, 1, 10300);
INSERT INTO Comensal VALUES ('Sofia', 'Luna', 'Guerrero', 'SFLG120936SLDJCNE4', 2018, 2, 10400);
INSERT INTO Comensal VALUES ('Jesús', 'Estrada', 'López', 'JUEL345092XWIJBSH8', 1951, 1, 10500);
INSERT INTO Comensal VALUES ('Fernanda', 'González', 'Morales', 'FGSM234567PONDLAE2', 1995, 2, 10600);
INSERT INTO Comensal VALUES ('Andrea', 'Cruz', 'Rivera', 'ANCR345389YCADHLP5', 1999, 2, 10700);
INSERT INTO Comensal VALUES ('Valerio', 'Rojas', 'Castro', 'VLRC129237ABXMEIR9', 1981, 1, 10800);
INSERT INTO Comensal VALUES ('Rebeca', 'Torres', 'Valle', 'ZRUB239845SLFURB3', 2001, 2, 10900);
INSERT INTO Comensal VALUES ('Omar', 'Cevilla', 'Estrada', 'OCLE984565MNBVSR8', 2000, 1, 11000);
INSERT INTO Comensal VALUES ('Berenice', 'Guitierrez', 'Leal', 'GULB781220MDFTLR03', 1999, 2, 11100);
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

INSERT INTO Asistencia VALUES (2, 1, 2, 1, '2023-10-20');
INSERT INTO Asistencia VALUES (2, 2, 1, 1, '2023-10-20');
INSERT INTO Asistencia VALUES (2, 3, 2, 1, '2023-10-20');
INSERT INTO Asistencia VALUES (2, 10, 1, 1, '2023-10-20');
INSERT INTO Asistencia VALUES (2, 3, 2, 1, '2023-10-20');
INSERT INTO Asistencia VALUES (2, 4, 1, 1, '2023-10-20');
INSERT INTO Asistencia VALUES (2, 5, 2, 2, '2023-10-20');

INSERT INTO Asistencia VALUES (2, 12, 2, 1, '2023-10-20');
INSERT INTO Asistencia VALUES (2, 6, 2, 1, '2023-10-20');
INSERT INTO Asistencia VALUES (2, 2, 2, 1, '2023-10-20');
INSERT INTO Asistencia VALUES (2, 8, 2, 1, '2023-10-20');
INSERT INTO Asistencia VALUES (2, 9, 1, 2, '2023-10-20');

INSERT INTO Asistencia VALUES (3, 4, 1, 1, '2023-10-20');
INSERT INTO Asistencia VALUES (3, 7, 2, 1, '2023-10-20');
INSERT INTO Asistencia VALUES (3, 4, 1, 1, '2023-10-20');
INSERT INTO Asistencia VALUES (3, 5, 1, 1, '2023-10-20');
INSERT INTO Asistencia VALUES (3, 5, 2, 1, '2023-10-20');
INSERT INTO Asistencia VALUES (4, 6, 1, 1, '2023-10-20');
INSERT INTO Asistencia VALUES (4, 7, 1, 1, '2023-10-20');
INSERT INTO Asistencia VALUES (4, 6, 2, 1, '2023-10-20');

INSERT INTO Asistencia VALUES (5, 11, 1, 1, '2023-10-20');
INSERT INTO Asistencia VALUES (5, 8, 1, 1, '2023-10-20');
INSERT INTO Asistencia VALUES (5, 9, 1, 1, '2023-10-20');
INSERT INTO Asistencia VALUES (5, 9, 2, 1, '2023-10-20');
INSERT INTO Asistencia VALUES (6, 10, 1, 1, '2023-10-20');
INSERT INTO Asistencia VALUES (6, 11, 1, 1, '2023-10-20');
INSERT INTO Asistencia VALUES (6, 2, 1, 1, '2023-10-20');
INSERT INTO Asistencia VALUES (6, 1, 2, 1, '2023-10-20');
INSERT INTO Asistencia VALUES (6, 3, 2, 1, '2023-10-20');
INSERT INTO Asistencia VALUES (6, 4, 1, 1, '2023-10-20');

INSERT INTO Asistencia VALUES (7, 6, 1, 1, '2023-10-20');
INSERT INTO Asistencia VALUES (7, 7, 1, 1, '2023-10-20');
INSERT INTO Asistencia VALUES (7, 8, 1, 1, '2023-10-20');

INSERT INTO Asistencia VALUES (8, 11, 1, 1, '2023-10-20');
INSERT INTO Asistencia VALUES (8, 8, 1, 1, '2023-10-20');
INSERT INTO Asistencia VALUES (8, 9, 1, 1, '2023-10-20');
INSERT INTO Asistencia VALUES (8, 9, 2, 1, '2023-10-20');
INSERT INTO Asistencia VALUES (8, 10, 1, 1, '2023-10-20');
INSERT INTO Asistencia VALUES (9, 11, 1, 1, '2023-10-20');
INSERT INTO Asistencia VALUES (9, 2, 1, 1, '2023-10-20');
INSERT INTO Asistencia VALUES (9, 1, 2, 1, '2023-10-20');
INSERT INTO Asistencia VALUES (9, 3, 2, 1, '2023-10-20');
INSERT INTO Asistencia VALUES (9, 4, 1, 1, '2023-10-20');

INSERT INTO Asistencia VALUES (10, 6, 1, 1, '2023-10-20');
INSERT INTO Asistencia VALUES (10, 7, 1, 1, '2023-10-20');
INSERT INTO Asistencia VALUES (10, 8, 1, 1, '2023-10-20');
INSERT INTO Asistencia VALUES (10, 11, 1, 1, '2023-10-20');
INSERT INTO Asistencia VALUES (10, 12, 1, 1, '2023-10-20');


INSERT INTO Asistencia VALUES (11, 6, 1, 1, '2023-10-20');
INSERT INTO Asistencia VALUES (11, 7, 1, 1, '2023-10-20');
INSERT INTO Asistencia VALUES (11, 8, 1, 1, '2023-10-20');

INSERT INTO Asistencia VALUES (11, 11, 1, 1, '2023-10-20');
INSERT INTO Asistencia VALUES (11, 8, 1, 1, '2023-10-20');
INSERT INTO Asistencia VALUES (12, 9, 1, 1, '2023-10-20');
INSERT INTO Asistencia VALUES (12, 9, 2, 1, '2023-10-20');
INSERT INTO Asistencia VALUES (12, 10, 1, 1, '2023-10-20');
INSERT INTO Asistencia VALUES (12, 11, 1, 1, '2023-10-20');
INSERT INTO Asistencia VALUES (13, 2, 1, 1, '2023-10-20');
INSERT INTO Asistencia VALUES (13, 1, 2, 1, '2023-10-20');
INSERT INTO Asistencia VALUES (13, 3, 2, 1, '2023-10-20');
INSERT INTO Asistencia VALUES (13, 4, 1, 1, '2023-10-20');

INSERT INTO Asistencia VALUES (13, 6, 1, 1, '2023-10-20');
INSERT INTO Asistencia VALUES (14, 7, 1, 1, '2023-10-20');
INSERT INTO Asistencia VALUES (14, 8, 1, 1, '2023-10-20');
INSERT INTO Asistencia VALUES (14, 11, 1, 1, '2023-10-20');
INSERT INTO Asistencia VALUES (14, 12, 1, 1, '2023-10-20');


INSERT INTO Asistencia VALUES (15, 6, 1, 1, '2023-10-20');
INSERT INTO Asistencia VALUES (15, 7, 1, 1, '2023-10-20');
INSERT INTO Asistencia VALUES (15, 8, 1, 1, '2023-10-20');

INSERT INTO Asistencia VALUES (15, 11, 1, 1, '2023-10-20');
INSERT INTO Asistencia VALUES (16, 8, 1, 1, '2023-10-20');
INSERT INTO Asistencia VALUES (16, 9, 1, 1, '2023-10-20');
INSERT INTO Asistencia VALUES (16, 9, 2, 1, '2023-10-20');
INSERT INTO Asistencia VALUES (16, 10, 1, 1, '2023-10-20');
INSERT INTO Asistencia VALUES (16, 11, 1, 1, '2023-10-20');
INSERT INTO Asistencia VALUES (17, 2, 1, 1, '2023-10-20');
INSERT INTO Asistencia VALUES (17, 1, 2, 1, '2023-10-20');
INSERT INTO Asistencia VALUES (17, 3, 2, 1, '2023-10-20');
INSERT INTO Asistencia VALUES (17, 4, 1, 1, '2023-10-20');

INSERT INTO Asistencia VALUES (17, 6, 1, 1, '2023-10-20');
INSERT INTO Asistencia VALUES (18, 7, 1, 1, '2023-10-20');
INSERT INTO Asistencia VALUES (18, 8, 1, 1, '2023-10-20');
INSERT INTO Asistencia VALUES (18, 11, 1, 1, '2023-10-20');
INSERT INTO Asistencia VALUES (18, 12, 1, 1, '2023-10-20');


INSERT INTO Asistencia VALUES (19, 6, 1, 1, '2023-10-20');
INSERT INTO Asistencia VALUES (19, 7, 1, 1, '2023-10-20');
INSERT INTO Asistencia VALUES (19, 8, 1, 1, '2023-10-20');
INSERT INTO Asistencia VALUES (19, 11, 1, 1, '2023-10-20');
INSERT INTO Asistencia VALUES (19, 8, 1, 1, '2023-10-20');
INSERT INTO Asistencia VALUES (20, 9, 1, 1, '2023-10-20');
INSERT INTO Asistencia VALUES (20, 9, 2, 1, '2023-10-20');
INSERT INTO Asistencia VALUES (20, 10, 1, 1, '2023-10-20');
INSERT INTO Asistencia VALUES (20, 11, 1, 1, '2023-10-20');
INSERT INTO Asistencia VALUES (20, 2, 1, 1, '2023-10-20');
INSERT INTO Asistencia VALUES (21, 1, 2, 1, '2023-10-20');
INSERT INTO Asistencia VALUES (21, 3, 2, 1, '2023-10-20');
INSERT INTO Asistencia VALUES (21, 4, 1, 1, '2023-10-20');

INSERT INTO Asistencia VALUES (21, 6, 1, 1, '2023-10-20');
INSERT INTO Asistencia VALUES (21, 7, 1, 1, '2023-10-20');
INSERT INTO Asistencia VALUES (22, 8, 1, 1, '2023-10-20');
INSERT INTO Asistencia VALUES (22, 11, 1, 1, '2023-10-20');
INSERT INTO Asistencia VALUES (22, 12, 1, 1, '2023-10-20');

INSERT INTO Asistencia VALUES (23, 6, 1, 1, '2023-10-20');
INSERT INTO Asistencia VALUES (23, 7, 1, 1, '2023-10-20');
INSERT INTO Asistencia VALUES (23, 8, 1, 1, '2023-10-20');
INSERT INTO Asistencia VALUES (23, 11, 1, 1, '2023-10-20');
INSERT INTO Asistencia VALUES (23, 12, 1, 1, '2023-10-20');


INSERT INTO Asistencia VALUES (24, 6, 1, 1, '2023-10-20');
INSERT INTO Asistencia VALUES (24, 7, 1, 1, '2023-10-20');
INSERT INTO Asistencia VALUES (24, 8, 1, 1, '2023-10-20');
INSERT INTO Asistencia VALUES (24, 11, 1, 1, '2023-10-20');
INSERT INTO Asistencia VALUES (24, 8, 1, 1, '2023-10-20');
INSERT INTO Asistencia VALUES (24, 9, 1, 1, '2023-10-20');
INSERT INTO Asistencia VALUES (25, 9, 2, 1, '2023-10-20');
INSERT INTO Asistencia VALUES (25, 10, 1, 1, '2023-10-20');
INSERT INTO Asistencia VALUES (25, 11, 1, 1, '2023-10-20');
INSERT INTO Asistencia VALUES (25, 2, 1, 1, '2023-10-20');
INSERT INTO Asistencia VALUES (25, 1, 2, 1, '2023-10-20');
INSERT INTO Asistencia VALUES (26, 3, 2, 1, '2023-10-20');
INSERT INTO Asistencia VALUES (26, 4, 1, 1, '2023-10-20');

INSERT INTO Asistencia VALUES (26, 6, 1, 1, '2023-10-20');
INSERT INTO Asistencia VALUES (26, 7, 1, 1, '2023-10-20');
INSERT INTO Asistencia VALUES (26, 8, 1, 1, '2023-10-20');
INSERT INTO Asistencia VALUES (26, 11, 1, 1, '2023-10-20');
INSERT INTO Asistencia VALUES (26, 12, 1, 1, '2023-10-20');

GO


-- IDComedor, IDComensal, IDTipoRacion, Raciones, Fecha
