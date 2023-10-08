const express = require('express');
const mssql = require('mssql');
const cors = require('cors');
const helmet = require('helmet');

const port = 8080;
const ipAddr = '3.95.129.111';

const app = express();
app.use(express.static(__dirname + '/public'));
app.use(express.json());
app.use(helmet());
app.use(cors());

const dbConfig = {
    user: process.env.MSSQL_USER,
    password: process.env.MSSQL_PASSWORD,
    database: 'ComedorBD',
    server: 'localhost',
    pool: { max: 10, min: 0, idleTimeoutMillis: 30000 },
    options: { trustServerCertificate: true }
};

function generateRandomNumber(length) {
  if (length < 1 || length > 10) {
    // Length should be between 1 and 10 for single digits.
    return null;
  }

  const digits = Array.from({ length: 10 }, (_, i) => i);
  let result = '';

  // Ensure the first digit is not zero.
  const firstDigit = Math.floor(Math.random() * 9) + 1;
  result += firstDigit;
  digits.splice(digits.indexOf(firstDigit), 1);

  // Shuffle the remaining digits and add them to the result.
  for (let i = 1; i < length; i++) {
    const randomIndex = Math.floor(Math.random() * digits.length);
    const randomDigit = digits.splice(randomIndex, 1)[0];
    result += randomDigit;
  }

  return result;
}


/*------------------------------ ENVÍO DE DATOS ----------------------------- */

/*---------------- WEB ---------------- */
// Insertar un Empleado (Supervisor)
app.post('/insertaSupervisor', async(req, res) => {
  try {
    const {nombre, apellidoP, apellidoM, fechaNacm, sexo, correo, nombreUsuario, contra} = req.body;
    
    const pool = await mssql.connect(dbConfig);
    
    const request = pool.request();
    request.input('Nombre', mssql.VarChar(30), nombre);
    request.input('ApellidoP', mssql.VarChar(30), apellidoP);
    request.input('ApellidoM', mssql.VarChar(30), apellidoM);
    request.input('FechaNacim', mssql.Int(), fechaNacm);
    request.input('DescSexo', mssql.VarChar(30), sexo);
    request.input('Correo', mssql.VarChar(40), correo);
    request.input('NombreUsuario', mssql.VarChar(40), nombreUsuario);
    request.input('Contraseña', mssql.VarChar(96), contra);
    const result = await request.execute('PROC_IEmpleadoS');
    
    return res.status(200).send('Supervisor agregado');
    
  } catch (err) {
    return res.status(500).send('Error al insertar el empleado');
  }
});


// Login del Supervisor
app.post('/loginSupervisor', async(req, res) => {
  try {
    const {nombreUsuario, contra} = req.body;
    
    const pool = await mssql.connect(dbConfig);
    
    const request = pool.request();
    request.input('NombreUsuario', mssql.VarChar(40), nombreUsuario);
    request.input('Contraseña', mssql.VarChar(96), contra);
    request.output('Exito', mssql.Bit());
    const result = await request.execute('PROC_LoginEmpS');
    
    if(result.output.Exito == true) {
      return res.status(201).send('OK');
    } else {
      return res.status(401).send('Nombre de Usuario y/o contraseña incorrecta');
    }
    
  } catch (err) {
    return res.status(500).send('Error en la conexión a la BD');
  }
});


// Insertar un Empleado (Encargado)
app.post('/insertaEncargado', async(req, res) => {
  try {
    const {nombre, apellidoP, apellidoM, fechaNacm, sexo, correo, nombreUsuario, contra} = req.body;
    
    const pool = await mssql.connect(dbConfig);
    
    const request = pool.request();
    request.input('Nombre', mssql.VarChar(30), nombre);
    request.input('ApellidoP', mssql.VarChar(30), apellidoP);
    request.input('ApellidoM', mssql.VarChar(30), apellidoM);
    request.input('FechaNacim', mssql.Int(), fechaNacm);
    request.input('DescSexo', mssql.VarChar(30), sexo);
    request.input('Correo', mssql.VarChar(40), correo);
    request.input('NombreUsuario', mssql.VarChar(40), nombreUsuario);
    request.input('Contraseña', mssql.VarChar(96), contra);
    const result = await request.execute('PROC_IEmpleadoE');
    
    return res.status(200).send('Encargado agregado');
    
  } catch (err) {
    return res.status(500).send('Error al insertar el empleado');
  }
});


// Insertar un Comedor
app.post('/insertaComedor', async(req, res) => {
  try {
    const {correoEmp, estadoCom, nombre, capacidad, dir, tel} = req.body;
    
    const pool = await mssql.connect(dbConfig);
    
    const request = pool.request();
    request.input('CorreoEmpleado', mssql.VarChar(40), correoEmp);
    request.input('NombreEstadoC', mssql.VarChar(30), estadoCom);
    request.input('Nombre', mssql.VarChar(30), nombre);
    request.input('Capacidad', mssql.Int(), capacidad);
    request.input('Direccion', mssql.VarChar(50), dir);
    request.input('Telefono', mssql.VarChar(30), tel);
    const result = await request.execute('PROC_IComedor');
    
    return res.status(200).send('Comedor agregado');
    
  } catch (err) {
    return res.status(500).send('Error al insertar el comedor');
  }
});


/*---------------- APP VOL/ENC ---------------- */
// Login del Encargado
app.post('/loginEncargado', async(req, res) => {
  try {
    const {nombreUsuario, contra} = req.body;
    
    const pool = await mssql.connect(dbConfig);
    
    const request = pool.request();
    request.input('NombreUsuario', mssql.VarChar(40), nombreUsuario);
    request.input('Contraseña', mssql.VarChar(96), contra);
    request.output('Exito', mssql.Bit());
    const result = await request.execute('PROC_LoginEmpE');
    const table = result.recordset;
    
    if(result.output.Exito == true) {
      return res.status(201).send({table});
    } else {
      return res.status(401).send('Nombre de Usuario y/o contraseña incorrecta');
    }
    
  } catch (err) {
    return res.status(500).send('Error en la conexión a la BD');
  }
});


// Insertar el Menú del día
app.post('/insertaMenu', async(req, res) => {
  try {
    const {nombreCom, sopaArroz, platoFuerte, panToritilla, aguaDelDia, frijolesSalsa, fecha} = req.body;
    
    const pool = await mssql.connect(dbConfig);
    
    const request = pool.request();
    request.input('NombreComedor', mssql.VarChar(30), nombreCom);
    request.input('SopaArroz', mssql.VarChar(50), sopaArroz);
    request.input('PlatoFuerte', mssql.VarChar(50), platoFuerte);
    request.input('PanToritilla', mssql.VarChar(50), panToritilla);
    request.input('AguaDelDia', mssql.VarChar(50), aguaDelDia);
    request.input('FrijolesSalsa', mssql.VarChar(50), frijolesSalsa);
    request.input('Fecha', mssql.Date, fecha);
    const result = await request.execute('PROC_IMenu');
    
    return res.status(200).send('Menú agregado');
    
  } catch (err) {
    return res.status(500).send('Error al insertar el menú');
  }
});


// Insertar una Incidencia
app.post('/insertaIncidencia', async(req, res) => {
  try {
    const {nombreCom, tipo, desc, fecha} = req.body;
    
    const pool = await mssql.connect(dbConfig);
    
    const request = pool.request();
    request.input('NombreComedor', mssql.VarChar(30), nombreCom);
    request.input('Tipo', mssql.VarChar(30), tipo);
    request.input('Descripcion', mssql.VarChar(60), desc);
    request.input('Fecha', mssql.Date, fecha);
    const result = await request.execute('PROC_IIncidencias');
    
    return res.status(200).send('Incidencia agregada');
    
  } catch (err) {
    return res.status(500).send('Error al insertar la incidencia');
  }
});


// Insertar a un Comensal son sus Condiciones
app.post('/insertaComensalCond', async(req, res) => {
  try {
    const {nombre, apellidoP, apellidoM, curp, fechaNacm, sexo, nombreCond} = req.body;

    const pool = await mssql.connect(dbConfig);

    const request1 = pool.request();
    request1.input('Nombre', mssql.VarChar(30), nombre); 
    request1.input('ApellidoP', mssql.VarChar(30), apellidoP);
    request1.input('ApellidoM', mssql.VarChar(30), apellidoM);
    request1.input('CURP', mssql.VarChar(18), curp);
    request1.input('FechaNacim', mssql.Int, fechaNacm);
    request1.input('DescSexo', mssql.VarChar(30), sexo);
    const token = parseInt(generateRandomNumber(5));
    request1.input('Token', mssql.Int, token);
    const result1 = await request1.execute('PROC_IComensal');

    for (const i of nombreCond){
      const request2 = pool.request();
      request2.input('ComensalCURP', mssql.VarChar(18), curp);
      request2.input('NombreCond', mssql.VarChar(30), i);
      const result2 = await request2.execute('PROC_ICondCom');
    }

    return res.status(201).send({token})
    
  } catch (err) {
    return res.status(401).send('Error, puede que el Comensal ya esté registrado');
  }
});


// Insertar una Asistencia
app.post('/insertaAsistencia', async(req, res) => {
  try {
    const {nombreCom, tipoRacion, raciones, fecha, tipoAcceso} = req.body;
    
    const pool = await mssql.connect(dbConfig);
    
    const request = pool.request();
    request.input('NombreComedor', mssql.VarChar(30), nombreCom);
    request.input('TipoRacion', mssql.VarChar(20), tipoRacion);
    request.input('Raciones', mssql.Int, raciones);
    request.input('Fecha', mssql.Date, fecha);
    
    // Cambio a 5 en If
    if (String(tipoAcceso).length == 4) {
      request.input('Token', mssql.Int, tipoAcceso);
      const result = await request.execute('PROC_IAsistenciaT');
    } else {
      request.input('ComensalCURP', mssql.VarChar(18), tipoAcceso);
      const result = await request.execute('PROC_IAsistenciaC');
    }
    
    return res.status(200).send('Asistencia agregada');
    
  } catch (err) {
    return res.status(500).send('Error al insertar la asistencia');
  }
});


/*---------------- APP COM ---------------- */
// Insertar una Encuesta
app.post('/insertaEncuesta', async(req, res) => {
  try {
    const {nombreCom, pregunta, comentarios, cali, fecha} = req.body;
    
    const pool = await mssql.connect(dbConfig);
    
    const request = pool.request();
    request.input('NombreComedor', mssql.VarChar(30), nombreCom);
    request.input('Pregunta', mssql.VarChar(60), pregunta);
    request.input('Comentarios', mssql.VarChar(80), comentarios);
    request.input('Calificacion', mssql.Int, cali);
    request.input('Fecha', mssql.Date, fecha);
    const result = await request.execute('PROC_IEncuesta');
    
    return res.status(200).send('Encuesta agregada');
    
  } catch (err) {
    return res.status(500).send('Error al insertar la encuesta');
  }
});



/*----------------------- ACTUALIZADO Y BORRADO ----------------------------- */

/*---------------- WEB ---------------- */
// Actualizar un Empleado
app.put('/actualizaEmpleado', async (req, res) => {
  try {
    const {idEmp, nombre, apellidoP, apellidoM, fechaNacm, sexo, correo, nombreUsuario} = req.body;
    
    const pool = await mssql.connect(dbConfig);
    
    const request = pool.request();
    request.input('IDEmpleado', mssql.Int(), idEmp);
    request.input('Nombre', mssql.VarChar(30), nombre);
    request.input('ApellidoP', mssql.VarChar(30), apellidoP);
    request.input('ApellidoM', mssql.VarChar(30), apellidoM);
    request.input('FechaNacim', mssql.Int(), fechaNacm);
    request.input('DescSexo', mssql.VarChar(30), sexo);
    request.input('Correo', mssql.VarChar(40), correo);
    request.input('NombreUsuario', mssql.VarChar(40), nombreUsuario);
    const result = await request.execute('PROC_AEmpleado');
    
    return res.status(200).send('Empleado Actualizado');
    
  } catch (err) {
    return res.status(500).send('Error al actualizar datos');
  }
});


// Actualizar la Contraseña de un empleado
app.put('/actualizaContraEmp', async (req, res) => {
  try {
    const {idEmp, contra} = req.body;
    
    const pool = await mssql.connect(dbConfig);
    
    const request = pool.request();
    request.input('IDEmpleado', mssql.Int(), idEmp);
    request.input('Contraseña', mssql.VarChar(96), contra);
    const result = await request.execute('PROC_AContraEmp');
    
    return res.status(200).send('Contraseña actualizada');
    
  } catch (err) {
    return res.status(500).send('Error al actualizar contraseña');
  }
});


// Borrar un Empleado
app.delete('/eliminaEmpleado', async (req, res) => {
  try {
    const {nombre} = req.body;
    
    const pool = await mssql.connect(dbConfig);
    
    const request = pool.request();
    request.input('NombreUsuario', mssql.VarChar(40), nombre);
    const result = await request.execute('PROC_BEmpleado');
    
    return res.status(200).send('El Empleado se ha borrado');
    
  } catch (err) {
    return res.status(500).send('Error al borrar el empleado');
  }
});


// Actualizar un Comedor
app.put('/actualizaComedor', async (req, res) => {
  try {
    const {idCom, correoEmp, estadoCom, nombre, capacidad, dir, tel} = req.body;
    
    const pool = await mssql.connect(dbConfig);
    
    const request = pool.request();
    request.input('IDComedor', mssql.Int(), idCom);
    request.input('CorreoEmpleado', mssql.VarChar(40), correoEmp);
    request.input('NombreEstadoC', mssql.VarChar(30), estadoCom);
    request.input('Nombre', mssql.VarChar(30), nombre);
    request.input('Capacidad', mssql.Int, capacidad);
    request.input('Direccion', mssql.VarChar(50), dir);
    request.input('Telefono', mssql.VarChar(30), tel);
    const result = await request.execute('PROC_AComedor');
    
    return res.status(200).send('Comedor actualizado');
    
  } catch (err) {
    return res.status(500).send('Error al actualizar datos');
  }
});


/*---------------- WEB // APP COM/ENC ---------------- */
// Actualizar el Estado de un comedor
app.put('/actualizaEstadoCom', async (req, res) => {
  try {
    const {nombreCom, estadoCom} = req.body;
    
    const pool = await mssql.connect(dbConfig);
    
    const request = pool.request();
    request.input('NombreComedor', mssql.VarChar(30), nombreCom);
    request.input('NombreEstadoC', mssql.VarChar(30), estadoCom);
    const result = await request.execute('PROC_AEstadoComedor');
    
    return res.status(200).send('Estado del comedor actualizado');
    
  } catch (err) {
    return res.status(500).send('Error al actualizar el estado');
  }
});



/*------------------------------ GRÁFICAS ------------------------------------*/

/*---------------- WEB ---------------- */
// Tabla de Información sobre los Supervisores
app.get('/supervisoresInfo/:pag', async (req, res) => {
  try {
    const numPag = parseInt(req.params.pag);
    
    const pool = await mssql.connect(dbConfig);
    
    const request = pool.request();
    request.input('NumeroPag', mssql.Int(), numPag)
    const result = await request.execute('PROC_CEmpleadoS');
    const table = result.recordset;
    
    return res.status(200).send({table});
    
  } catch (err) {
    return res.status(400).send('Error en la conexón a la BD');
  }
});


// Tabla de Información sobre los Encargados
app.get('/encargadosInfo/:pag', async (req, res) => {
  try {
    const numPag = parseInt(req.params.pag);
    
    const pool = await mssql.connect(dbConfig);
    
    const request = pool.request();
    request.input('NumeroPag', mssql.Int(), numPag)
    const result = await request.execute('PROC_CEmpleadoE');
    const table = result.recordset;
    
    return res.status(200).send({table});
    
  } catch (err) {
    return res.status(400).send('Error en la conexón a la BD');
  }
});


// Tabla de Información sobre los Comedores
app.get('/comedoresInfo/:pag', async (req, res) => {
  try {
    const numPag = parseInt(req.params.pag);
    
    const pool = await mssql.connect(dbConfig);
    
    const request = pool.request();
    request.input('NumeroPag', mssql.Int(), numPag)
    const result = await request.execute('PROC_CComedor');
    const table = result.recordset;
    
    return res.status(200).send({table});
    
  } catch (err) {
    return res.status(400).send('Error en la conexón a la BD');
  }
});


/*--Sección de "Vista general de comedores"--*/
// Tabla de los Comedores con mayor asistencia
app.get('/mayorAsisCom/:fecha', async (req, res) => {
  try {
    const fecha = req.params.fecha;
    
    const pool = await mssql.connect(dbConfig);
    
    const request = pool.request();
    request.input('Fecha', mssql.Date, fecha)
    const result = await request.execute('PROC_CMayorAsis');
    const table = result.recordset;
    
    return res.status(200).send({table});
    
  } catch (err) {
    return res.status(400).send('Error en la conexón a la BD');
  }
});


// Tabla de las Raciones pagadas vs donadas
app.get('/racionesPagDon/:fecha', async (req, res) => {
  try {
    const fecha = req.params.fecha;
    
    const pool = await mssql.connect(dbConfig);
    
    const request = pool.request();
    request.input('Fecha', mssql.Date, fecha)
    const result = await request.execute('PROC_CPagarDonar');
    const table = result.recordset;
    
    return res.status(200).send({table});
    
  } catch (err) {
    return res.status(400).send('Error en la conexón a la BD');
  }
});


// Tabla de los grupos de Edades
app.get('/grupoEdades/:fecha', async (req, res) => {
  try {
    const fecha = req.params.fecha;
    
    const pool = await mssql.connect(dbConfig);
    
    const request = pool.request();
    request.input('Fecha', mssql.Date, fecha)
    const result = await request.execute('PROC_CEdades');
    const table = result.recordset;
    
    return res.status(200).send({table});
    
  } catch (err) {
    return res.status(400).send('Error en la conexón a la BD');
  }
});


// Tabla de las Condiciones por Fecha
app.get('/condiciones/:fecha', async (req, res) => {
  try {
    const fecha = req.params.fecha;
    
    const pool = await mssql.connect(dbConfig);
    
    const request = pool.request();
    request.input('Fecha', mssql.Date, fecha)
    const result = await request.execute('PROC_CCondiciones');
    const table = result.recordset;
    
    return res.status(200).send({table});
    
  } catch (err) {
    return res.status(400).send('Error en la conexón a la BD');
  }
});


// Tabla sobre las respuestas de la Encuesta
app.get('/encuesta/:nombreCom/:fecha', async (req, res) => {
  try {
    const nombreCom = req.params.nombreCom;
    const fecha = req.params.fecha;
    
    const pool = await mssql.connect(dbConfig);
    
    const request = pool.request();
    request.input('NombreComedor', mssql.VarChar(30), nombreCom)
    request.input('Fecha', mssql.Date, fecha)
    const result = await request.execute('PROC_CEncuesta');
    const table = result.recordset;
    
    return res.status(200).send({table});
    
  } catch (err) {
    return res.status(400).send('Error en la conexón a la BD');
  }
});


/*--Sección de "Vista por comedor"--*/
// Tabla sobre la Asistencia de un Comedor
app.get('/asistenciaCom/:nombreCom/:fecha', async (req, res) => {
  try {
    const nombreCom = req.params.nombreCom;
    const fecha = req.params.fecha;
    
    const pool = await mssql.connect(dbConfig);
    
    const request = pool.request();
    request.input('NombreComedor', mssql.VarChar(30), nombreCom)
    request.input('Fecha', mssql.Date, fecha)
    const result = await request.execute('PROC_CAsisComensales');
    const table = result.recordset;
    
    return res.status(200).send({table});
    
  } catch (err) {
    return res.status(400).send('Error en la conexón a la BD');
  }
});


// Tabla sobre la población en un Comedor
app.get('/poblacionCom/:nombreCom/:fecha', async (req, res) => {
  try {
    const nombreCom = req.params.nombreCom;
    const fecha = req.params.fecha;
    
    const pool = await mssql.connect(dbConfig);
    
    const request = pool.request();
    request.input('NombreComedor', mssql.VarChar(30), nombreCom)
    request.input('Fecha', mssql.Date, fecha)
    const result = await request.execute('PROC_CPoblaCome');
    const table = result.recordset;
    
    return res.status(200).send({table});
    
  } catch (err) {
    return res.status(400).send('Error en la conexón a la BD');
  }
});


// Tabla sobre el historial de la asistencia de los comensales
app.get('/historialAsis/:nombreCom', async (req, res) => {
  try {
    const nombreCom = req.params.nombreCom;
    
    const pool = await mssql.connect(dbConfig);
    
    const request = pool.request();
    request.input('NombreComedor', mssql.VarChar(30), nombreCom)
    const result = await request.execute('PROC_CHistAsisComen');
    const table = result.recordset;
    
    return res.status(200).send({table});
    
  } catch (err) {
    return res.status(400).send('Error en la conexón a la BD');
  }
});


// Tabla sobre las Raciones donadas de un Comedor
app.get('/racionesDonadas/:nombreCom', async (req, res) => {
  try {
    const nombreCom = req.params.nombreCom;
    
    const pool = await mssql.connect(dbConfig);
    
    const request = pool.request();
    request.input('NombreComedor', mssql.VarChar(30), nombreCom)
    const result = await request.execute('PROC_CRacionDonada');
    const table = result.recordset;
    
    return res.status(200).send({table});
    
  } catch (err) {
    return res.status(400).send('Error en la conexón a la BD');
  }
});


// Tabla sobre las Incidencias de los comedores
app.get('/reporteIncidencia/:fecha', async (req, res) => {
  try {
    const fecha = req.params.fecha;
    
    const pool = await mssql.connect(dbConfig);
    
    const request = pool.request();
    request.input('Fecha', mssql.Date, fecha)
    const result = await request.execute('PROC_CIncidencias');
    const table = result.recordset;
    
    return res.status(200).send({table});
    
  } catch (err) {
    return res.status(400).send('Error en la conexón a la BD');
  }
});


/*---------------- APP VOL/ENC ---------------- */
// Catálogo sobre las Condiciones de un comensal
app.get('/condicionComensal', async(req, res) => {
  try {
    const pool = await mssql.connect(dbConfig);
    const request = pool.request();
    const result = await request.execute('PROC_CCondicion');
    const table = result.recordset;
    
    return res.status(200).send({table});
    
  } catch (err) {
    return res.status(400).send('Error en la conexión a la BD');
  }
});


/*--Sección de "Dashboard"--*/
// Tabla que contiene las partes del DashBoard
app.get('/dashBoard/:nombreCom/:fecha', async (req, res) => {
  try {
    const nombreCom = req.params.nombreCom;
    const fecha = req.params.fecha;
    
    const pool = await mssql.connect(dbConfig);
    
    const request = pool.request();
    request.input('NombreComedor', mssql.VarChar(30), nombreCom)
    request.input('Fecha', mssql.Date, fecha)
    const result = await request.execute('PROC_CDashBoard');
    const table = result.recordset;
    
    return res.status(200).send({table});
    
  } catch (err) {
    return res.status(400).send('Error en la conexón a la BD');
  }
});


// Tabla sobre Competición sana entre Comedores
app.get('/dashBoardComp/:fecha', async (req, res) => {
  try {
    const fecha = req.params.fecha;
    
    const pool = await mssql.connect(dbConfig);
    
    const request = pool.request();
    request.input('Fecha', mssql.Date, fecha)
    const result = await request.execute('PROC_CDashBoardComp');
    const table = result.recordset;
    
    return res.status(200).send({table});
    
  } catch (err) {
    return res.status(400).send('Error en la conexón a la BD');
  }
});


/*---------------- APP COM ---------------- */
// Tabla sobre el Menu de un comedor
app.get('/verMenu/:nombreCom/:fecha', async (req, res) => {
  try {
    const nombreCom = req.params.nombreCom;
    const fecha = req.params.fecha;
    
    const pool = await mssql.connect(dbConfig);
    
    const request = pool.request();
    request.input('NombreComedor', mssql.VarChar(30), nombreCom)
    request.input('Fecha', mssql.Date, fecha)
    const result = await request.execute('PROC_CVerMenu');
    const table = result.recordset;
    
    return res.status(200).send({table});
    
  } catch (err) {
    return res.status(400).send('Error en la conexón a la BD');
  }
});


// Tabla sobre las Incidencias de un comedor
app.get('/reporteIncidenciaCom/:nombreCom/:fecha', async (req, res) => {
  try {
    const nombreCom = req.params.nombreCom;
    const fecha = req.params.fecha;
    
    const pool = await mssql.connect(dbConfig);
    
    const request = pool.request();
    request.input('NombreComedor', mssql.VarChar(30), nombreCom)
    request.input('Fecha', mssql.Date, fecha)
    const result = await request.execute('PROC_CIncidenciasC');
    const table = result.recordset;
    
    return res.status(200).send({table});
    
  } catch (err) {
    return res.status(400).send('Error en la conexón a la BD');
  }
});


// Tabla sobre el Correo de ayuda a comensales
app.get('/correoAyuda', async(req, res) => {
  try {
    const pool = await mssql.connect(dbConfig);
    
    const request = pool.request();
    const result = await request.execute('PROC_CSuperCorreo');
    const table = result.recordset;
    
    return res.status(200).send({table});
    
  } catch (err) {
    return res.status(400).send('Error en la conexión a la BD');
  }
});


// Tabla sobre los nombres de los Comedores
app.get('/nombreComedores', async(req, res) => {
  try {
    const pool = await mssql.connect(dbConfig);
    
    const request = pool.request();
    const result = await request.execute('PROC_CNombresCom');
    const table = result.recordset;
    
    return res.status(200).send({table});
    
  } catch (err) {
    return res.status(400).send('Error en la conexión a la BD');
  }
});


// Tabla sobre las Preguntas
app.get('/preguntas', async(req, res) => {
  try {
    const pool = await mssql.connect(dbConfig);
    
    const request = pool.request();
    const result = await request.execute('PROC_CPreguntas');
    const table = result.recordset;
    
    return res.status(200).send({table});
    
  } catch (err) {
    return res.status(400).send('Error en la conexión a la BD');
  }
});


// Tabla sobre las Raciones donadas de un Comedor
app.get('/estadoCom/:nombreCom', async (req, res) => {
  try {
    const nombreCom = req.params.nombreCom;
    
    const pool = await mssql.connect(dbConfig);
    
    const request = pool.request();
    request.input('NombreComedor', mssql.VarChar(30), nombreCom)
    const result = await request.execute('PROC_CEstadoCom');
    const table = result.recordset;
    
    return res.status(200).send({table});
    
  } catch (err) {
    return res.status(400).send('Error en la conexón a la BD');
  }
});



/*---------------------- APLICACIÓN Y PÁGINA 404 -----------------------------*/


app.use((req, res) => {
  res.type('text/plain').status(404).send('404 - Not Found');
});

app.listen(port, () => console.log(
  `Express started on http://${ipAddr}:${port}`
  + '\nPress Ctrl-C to terminate.'));