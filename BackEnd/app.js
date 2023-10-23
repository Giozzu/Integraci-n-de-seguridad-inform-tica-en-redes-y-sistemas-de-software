/**
 * Autores:
 * 
 * Alfredo Azamar López
 * Héctor González Sánchez
 */

const express = require('express');
const mssql = require('mssql');
const cors = require('cors');
const helmet = require('helmet');
const fs = require('fs');
const https = require('https');

// Leer los certificados SSL para HTTPS
const certificate = fs.readFileSync('/etc/letsencrypt/live/platopatodose3.ddns.net/fullchain.pem', 'utf8')
const privateKey = fs.readFileSync('/etc/letsencrypt/live/platopatodose3.ddns.net/privkey.pem', 'utf8')
const credentials = { key: privateKey, cert: certificate}

const port = 8080;
const domain = 'platopatodose3.ddns.net';
const app = express();

// Configurar el servidor Express
app.use(express.static(__dirname + '/public'));
app.use(express.json());
app.use(helmet());
app.use(cors());

// Crear un servidor HTTPS utilizando los certificados
const httpsServer = https.createServer(credentials, app)

const dbConfig = {
    user: process.env.MSSQL_USER,
    password: process.env.MSSQL_PASSWORD,
    database: 'ComedorBD',
    server: 'localhost',
    pool: { max: 10, min: 0, idleTimeoutMillis: 30000 },
    options: { trustServerCertificate: true }
};

/**
 * Genera un número aleatorio único con una longitud especificada.
 *
 * @param {number} length - La longitud del número aleatorio (entre 1 y 10).
 * @returns {string | null} - El número aleatorio generado o null si la longitud no es válida.
 */
function generateRandomNumber(length) {
  if (length < 1 || length > 10) {
    return null;
  }

  const digits = Array.from({ length: 10 }, (_, i) => i);
  let result = '';

  const firstDigit = Math.floor(Math.random() * 9) + 1;
  result += firstDigit;
  digits.splice(digits.indexOf(firstDigit), 1);

  for (let i = 1; i < length; i++) {
    const randomIndex = Math.floor(Math.random() * digits.length);
    const randomDigit = digits.splice(randomIndex, 1)[0];
    result += randomDigit;
  }

  return result;
}


/*------------------------------ ENVÍO DE DATOS ----------------------------- */
/**
 * Ruta para insertar un empleado Supervisor.
 *
 * @name POST /insertaSupervisor
 * @param {Object} req - Objeto de solicitud HTTP.
 * @param {Object} res - Objeto de respuesta HTTP.
 * @returns {Object} - Respuesta HTTP con estado 200 si el Supervisor se agrega con éxito, o estado 500 en caso de error.
 */
app.post('/insertaSupervisor', async(req, res) => {
  try {
    const {nombre, apellidoP, apellidoM, fechaNacim, sexo, correo, nombreUsuario, contra} = req.body;
    
    const pool = await mssql.connect(dbConfig);
    
    const request = pool.request();
    request.input('Nombre', mssql.VarChar(30), nombre);
    request.input('ApellidoP', mssql.VarChar(30), apellidoP);
    request.input('ApellidoM', mssql.VarChar(30), apellidoM);
    request.input('FechaNacim', mssql.Int(), fechaNacim);
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


/**
 * Ruta para el inicio de sesión del Supervisor.
 *
 * @name POST /loginSupervisor
 * @param {Object} req - Objeto de solicitud HTTP que contiene el nombre de 
 *                       usuario y la contraseña del Supervisor.
 * @param {Object} res - Objeto de respuesta HTTP.
 * @returns {Object} - Respuesta HTTP con estado 201 (OK) si el inicio de sesión es exitoso,
 *                   - Respuesta HTTP con estado 401 (No autorizado) si el nombre de usuario y/o contraseña son incorrectos,
 *                   - Respuesta HTTP con estado 500 (Error del servidor) si hay un error en la conexión a la base de datos.
 */
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


/**
 * Ruta para insertar un nuevo Encargado.
 *
 * @name POST /insertaEncargado
 * @param {Object} req - Objeto de solicitud HTTP que contiene los datos del Encargado a insertar.
 * @param {Object} res - Objeto de respuesta HTTP.
 * @returns {Object} - Respuesta HTTP con estado 200 (OK) si el Encargado se agrega correctamente,
 *                   - Respuesta HTTP con estado 500 (Error del servidor) si hay un error al insertar el Encargado en la base de datos.
 */
app.post('/insertaEncargado', async(req, res) => {
  try {
    const {nombre, apellidoP, apellidoM, fechaNacim, sexo, correo, nombreUsuario, contra} = req.body;
    
    const pool = await mssql.connect(dbConfig);
    
    const request = pool.request();
    request.input('Nombre', mssql.VarChar(30), nombre);
    request.input('ApellidoP', mssql.VarChar(30), apellidoP);
    request.input('ApellidoM', mssql.VarChar(30), apellidoM);
    request.input('FechaNacim', mssql.Int(), fechaNacim);
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


/**
 * Ruta para insertar un nuevo Comedor.
 *
 * @name POST /insertaComedor
 * @param {Object} req - Objeto de solicitud HTTP que contiene los datos del Comedor a insertar.
 * @param {Object} res - Objeto de respuesta HTTP.
 * @returns {Object} - Respuesta HTTP con estado 200 (OK) si el Comedor se agrega correctamente,
 *                   - Respuesta HTTP con estado 500 (Error del servidor) si hay un error al insertar el Comedor en la base de datos.
 */
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


/**
 * Ruta para iniciar sesión del Encargado.
 *
 * @name POST /loginEncargado
 * @param {Object} req - Objeto de solicitud HTTP que contiene los datos de inicio de sesión del Encargado.
 * @param {Object} res - Objeto de respuesta HTTP.
 * @returns {Object} - Respuesta HTTP con estado 201 (Creado) si el inicio de sesión es exitoso y devuelve los datos del Encargado,
 *                   - Respuesta HTTP con estado 401 (No autorizado) si el nombre de usuario y/o la contraseña son incorrectos,
 *                   - Respuesta HTTP con estado 500 (Error del servidor) si hay un error en la conexión a la base de datos.
 */
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
      return res.status(401).json({message: 'Nombre de Usuario y/o contraseña incorrecta'});
    }
    
  } catch (err) {
    return res.status(500).json({message: 'Error en la conexión a la BD'});
  }
});


/**
 * Ruta para agregar un menú a un comedor.
 *
 * @name POST /insertaMenu
 * @param {Object} req - Objeto de solicitud HTTP que contiene los datos del menú a agregar.
 * @param {Object} res - Objeto de respuesta HTTP.
 * @returns {Object} - Respuesta HTTP con estado 200 (OK) y un mensaje de éxito si el menú se agrega correctamente,
 *                   - Respuesta HTTP con estado 500 (Error del servidor) si hay un error al insertar el menú.
 */
app.put('/insertaMenu', async(req, res) => {
  try {
    const {nombreCom, sopaArroz, platoFuerte, panTortilla, aguaDelDia, frijolesSalsa, fecha} = req.body;
    
    const pool = await mssql.connect(dbConfig);
    
    const request = pool.request();
    request.input('NombreComedor', mssql.VarChar(30), nombreCom);
    request.input('SopaArroz', mssql.VarChar(50), sopaArroz);
    request.input('PlatoFuerte', mssql.VarChar(50), platoFuerte);
    request.input('PanTortilla', mssql.VarChar(50), panTortilla);
    request.input('AguaDelDia', mssql.VarChar(50), aguaDelDia);
    request.input('FrijolesSalsa', mssql.VarChar(50), frijolesSalsa);
    request.input('Fecha', mssql.Date, fecha);
    const result = await request.execute('PROC_AMenu');
    
    return res.status(200).json({message: 'Menú agregado'});
    
  } catch (err) {
    return res.status(500).json({message: 'Error al insertar el menú'});
  }
});


/**
 * Ruta para reportar una incidencia en un comedor.
 *
 * @name POST /insertaIncidencia
 * @param {Object} req - Objeto de solicitud HTTP que contiene los datos de la incidencia a reportar.
 * @param {Object} res - Objeto de respuesta HTTP.
 * @returns {Object} - Respuesta HTTP con estado 200 (OK) y un mensaje de éxito si la incidencia se reporta correctamente,
 *                   - Respuesta HTTP con estado 500 (Error del servidor) si hay un error al reportar la incidencia.
 */
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
    
    return res.status(200).json({message: 'Incidencia reportada'});
    
  } catch (err) {
    return res.status(500).json({message: 'Error al reportar la incidencia'});
  }
});


/**
 * Ruta para registrar un comensal y sus condiciones alimentarias.
 *
 * @name POST /insertaComensalCond
 * @param {Object} req - Objeto de solicitud HTTP que contiene los datos del comensal y sus condiciones alimentarias.
 * @param {Object} res - Objeto de respuesta HTTP.
 * @returns {Object} - Respuesta HTTP con estado 201 (Creado) que incluye el token generado si el comensal se registra correctamente,
 *                   - Respuesta HTTP con estado 401 (No autorizado) si el comensal ya está registrado.
 */
 app.post('/insertaComensalCond', async(req, res) => {
  try {
    const {nombre, apellidoP, apellidoM, curp, fechaNacim, sexo, nombreCond} = req.body;

    const pool = await mssql.connect(dbConfig);

    const request1 = pool.request();
    request1.input('Nombre', mssql.VarChar(30), nombre); 
    request1.input('ApellidoP', mssql.VarChar(30), apellidoP);
    request1.input('ApellidoM', mssql.VarChar(30), apellidoM);
    request1.input('CURP', mssql.VarChar(18), curp);
    request1.input('FechaNacim', mssql.Int, fechaNacim);
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
    return res.status(401).json({message: 'Error, puede que el Comensal ya esté registrado'});
  }
});


/**
 * Ruta para registrar la asistencia en un comedor.
 *
 * @name POST /insertaAsistencia
 * @param {Object} req - Objeto de solicitud HTTP que contiene los datos de la asistencia.
 * @param {Object} res - Objeto de respuesta HTTP.
 * @returns {Object} - Respuesta HTTP con estado 200 (Éxito) si la asistencia se registra correctamente,
 *                   - Respuesta HTTP con estado 500 (Error del servidor) si hay un error en la conexión a la BD o al registrar la asistencia.
 */
app.post('/insertaAsistencia', async(req, res) => {
  try {
    const {nombreCom, tipoRacion, raciones, fecha, tipoAcceso} = req.body;
    
    const pool = await mssql.connect(dbConfig);
    
    const request = pool.request();
    request.input('NombreComedor', mssql.VarChar(30), nombreCom);
    request.input('TipoRacion', mssql.VarChar(20), tipoRacion);
    request.input('Raciones', mssql.Int, raciones);
    request.input('Fecha', mssql.Date, fecha);
    
    if (String(tipoAcceso).length == 5) {
      request.input('Token', mssql.Int, tipoAcceso);
      const result = await request.execute('PROC_IAsistenciaT');
    } else {
      request.input('ComensalCURP', mssql.VarChar(18), tipoAcceso);
      const result = await request.execute('PROC_IAsistenciaC');
    }
    
    return res.status(200).json({message: 'Asistencia registrada'});
    
  } catch (err) {
    return res.status(500).json({message: 'Error al registrar la asistencia'});
  }
});


/**
 * Ruta para registrar una encuesta en un comedor.
 *
 * @name POST /insertaEncuesta
 * @param {Object} req - Objeto de solicitud HTTP que contiene los datos de la encuesta.
 * @param {Object} res - Objeto de respuesta HTTP.
 * @returns {Object} - Respuesta HTTP con estado 200 (Éxito) si la encuesta se registra correctamente,
 *                   - Respuesta HTTP con estado 500 (Error del servidor) si hay un error al registrar la encuesta.
 */
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
    
    return res.status(200).json({message: 'Encuesta registrada'});
    
  } catch (err) {
    return res.status(500).json({message: 'Error al registrar la encuesta'});
  }
});



/*----------------------- ACTUALIZADO Y BORRADO ----------------------------- */
/**
 * Ruta para actualizar los datos de un empleado (Supervisor o Encargado) en la base de datos.
 *
 * @name PUT /actualizaEmpleado
 * @param {Object} req - Objeto de solicitud HTTP que contiene los datos actualizados del empleado.
 * @param {Object} res - Objeto de respuesta HTTP.
 * @returns {Object} - Respuesta HTTP con estado 200 (Éxito) si los datos del empleado se actualizan correctamente,
 *                   - Respuesta HTTP con estado 500 (Error del servidor) si hay un error al actualizar los datos del empleado.
 */
app.put('/actualizaEmpleado', async (req, res) => {
  try {
    const {idEmp, nombre, apellidoP, apellidoM, fechaNacim, sexo, correo, nombreUsuario} = req.body;
    
    const pool = await mssql.connect(dbConfig);
    
    const request = pool.request();
    request.input('IDEmpleado', mssql.Int(), idEmp);
    request.input('Nombre', mssql.VarChar(30), nombre);
    request.input('ApellidoP', mssql.VarChar(30), apellidoP);
    request.input('ApellidoM', mssql.VarChar(30), apellidoM);
    request.input('FechaNacim', mssql.Int(), fechaNacim);
    request.input('DescSexo', mssql.VarChar(30), sexo);
    request.input('Correo', mssql.VarChar(40), correo);
    request.input('NombreUsuario', mssql.VarChar(40), nombreUsuario);
    const result = await request.execute('PROC_AEmpleado');
    
    return res.status(200).send('Empleado Actualizado');
    
  } catch (err) {
    return res.status(500).send('Error al actualizar datos');
  }
});


/**
 * Ruta para actualizar la contraseña de un empleado (Supervisor o Encargado) en la base de datos.
 *
 * @name PUT /actualizaContraEmp
 * @param {Object} req - Objeto de solicitud HTTP que contiene la información para actualizar la contraseña del empleado.
 * @param {Object} res - Objeto de respuesta HTTP.
 * @returns {Object} - Respuesta HTTP con estado 200 (Éxito) si la contraseña del empleado se actualiza correctamente,
 *                   - Respuesta HTTP con estado 500 (Error del servidor) si hay un error al actualizar la contraseña del empleado.
 */
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


/**
 * Ruta para eliminar un empleado (Supervisor o Encargado) de la base de datos.
 *
 * @name DELETE /eliminaEmpleado
 * @param {Object} req - Objeto de solicitud HTTP que contiene la información para eliminar al empleado.
 * @param {Object} res - Objeto de respuesta HTTP.
 * @returns {Object} - Respuesta HTTP con estado 200 (Éxito) si el empleado se elimina correctamente,
 *                   - Respuesta HTTP con estado 500 (Error del servidor) si hay un error al eliminar al empleado.
 */
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


/**
 * Ruta para actualizar la información de un comedor en la base de datos.
 *
 * @name PUT /actualizaComedor
 * @param {Object} req - Objeto de solicitud HTTP que contiene la información para actualizar el comedor.
 * @param {Object} res - Objeto de respuesta HTTP.
 * @returns {Object} - Respuesta HTTP con estado 200 (Éxito) si la información del comedor se actualiza correctamente,
 *                   - Respuesta HTTP con estado 500 (Error del servidor) si hay un error al actualizar la información del comedor.
 */
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


/**
 * Ruta para actualizar el estado de un comedor en la base de datos.
 *
 * @name PUT /actualizaEstadoCom
 * @param {Object} req - Objeto de solicitud HTTP que contiene la información para actualizar el estado del comedor.
 * @param {Object} res - Objeto de respuesta HTTP.
 * @returns {Object} - Respuesta HTTP con estado 200 (Éxito) si el estado del comedor se actualiza correctamente,
 *                   - Respuesta HTTP con estado 500 (Error del servidor) si hay un error al actualizar el estado del comedor.
 */
app.put('/actualizaEstadoCom', async (req, res) => {
  try {
    const {nombreCom, estadoCom} = req.body;
    
    const pool = await mssql.connect(dbConfig);
    
    const request = pool.request();
    request.input('NombreComedor', mssql.VarChar(30), nombreCom);
    request.input('NombreEstadoC', mssql.VarChar(30), estadoCom);
    const result = await request.execute('PROC_AEstadoComedor');
    
    return res.status(200).json({message: 'Estado del comedor actualizado'});
    
  } catch (err) {
    return res.status(500).json({message: 'Error al actualizar el estado'});
  }
});



/*------------------------------ GRÁFICAS ------------------------------------*/
/**
 * Ruta para obtener información sobre los supervisores desde la base de datos.
 *
 * @name GET /supervisoresInfo/:pag
 * @param {Object} req - Objeto de solicitud HTTP que contiene el número de página.
 * @param {Object} res - Objeto de respuesta HTTP.
 * @returns {Object} - Respuesta HTTP con estado 200 (Éxito) y una tabla de información sobre supervisores si la solicitud se realiza correctamente,
 *                   - Respuesta HTTP con estado 400 (Solicitud incorrecta) si hay un error en la conexión a la base de datos.
 */
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


/**
 * Ruta para obtener información sobre los encargados desde la base de datos.
 *
 * @name GET /encargadosInfo/:pag
 * @param {Object} req - Objeto de solicitud HTTP que contiene el número de página.
 * @param {Object} res - Objeto de respuesta HTTP.
 * @returns {Object} - Respuesta HTTP con estado 200 (Éxito) y una tabla de información sobre encargados si la solicitud se realiza correctamente,
 *                   - Respuesta HTTP con estado 400 (Solicitud incorrecta) si hay un error en la conexión a la base de datos.
 */
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


/**
 * Ruta para obtener información sobre comedores desde la base de datos.
 *
 * @name GET /comedoresInfo/:pag
 * @param {Object} req - Objeto de solicitud HTTP que contiene el número de página.
 * @param {Object} res - Objeto de respuesta HTTP.
 * @returns {Object} - Respuesta HTTP con estado 200 (Éxito) y una tabla de información sobre comedores si la solicitud se realiza correctamente,
 *                   - Respuesta HTTP con estado 400 (Solicitud incorrecta) si hay un error en la conexión a la base de datos.
 */
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


/**
 * Ruta para obtener información sobre el comedor con la mayor asistencia en una fecha específica.
 *
 * @name GET /mayorAsisCom/:fecha
 * @param {Object} req - Objeto de solicitud HTTP que contiene la fecha para buscar la mayor asistencia.
 * @param {Object} res - Objeto de respuesta HTTP.
 * @returns {Object} - Respuesta HTTP con estado 200 (Éxito) y una tabla de información sobre el comedor con la mayor asistencia si la solicitud se realiza correctamente,
 *                   - Respuesta HTTP con estado 400 (Solicitud incorrecta) si hay un error en la conexión a la base de datos.
 */
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


/**
 * Ruta para obtener información sobre las raciones a pagar o donar en una fecha específica.
 *
 * @name GET /racionesPagDon/:fecha
 * @param {Object} req - Objeto de solicitud HTTP que contiene la fecha para buscar raciones a pagar o donar.
 * @param {Object} res - Objeto de respuesta HTTP.
 * @returns {Object} - Respuesta HTTP con estado 200 (Éxito) y una tabla de información sobre las raciones a pagar o donar si la solicitud se realiza correctamente,
 *                   - Respuesta HTTP con estado 400 (Solicitud incorrecta) si hay un error en la conexión a la base de datos.
 */
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


/**
 * Ruta para obtener información sobre grupos de edades en una fecha específica.
 *
 * @name GET /grupoEdades/:fecha
 * @param {Object} req - Objeto de solicitud HTTP que contiene la fecha para buscar información sobre grupos de edades.
 * @param {Object} res - Objeto de respuesta HTTP.
 * @returns {Object} - Respuesta HTTP con estado 200 (Éxito) y una tabla de información sobre grupos de edades si la solicitud se realiza correctamente,
 *                   - Respuesta HTTP con estado 400 (Solicitud incorrecta) si hay un error en la conexión a la base de datos.
 */
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


/**
 * Ruta para obtener información sobre las condiciones de los comensales en una fecha específica.
 *
 * @name GET /condiciones/:fecha
 * @param {Object} req - Objeto de solicitud HTTP que contiene la fecha para buscar información sobre las condiciones de los comensales.
 * @param {Object} res - Objeto de respuesta HTTP.
 * @returns {Object} - Respuesta HTTP con estado 200 (Éxito) y una tabla de información sobre las condiciones de los comensales si la solicitud se realiza correctamente,
 *                   - Respuesta HTTP con estado 400 (Solicitud incorrecta) si hay un error en la conexión a la base de datos.
 */
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


/**
 * Ruta para obtener información de encuestas de un comedor en una fecha específica.
 *
 * @name GET /encuesta/:nombreCom/:fecha
 * @param {Object} req - Objeto de solicitud HTTP que contiene el nombre del comedor y la fecha para buscar encuestas.
 * @param {Object} res - Objeto de respuesta HTTP.
 * @returns {Object} - Respuesta HTTP con estado 200 (Éxito) y una tabla de información de encuestas si la solicitud se realiza correctamente,
 *                   - Respuesta HTTP con estado 400 (Solicitud incorrecta) si hay un error en la conexión a la base de datos.
 */
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


/**
 * Ruta para obtener información de asistencia de comensales en un comedor en una fecha específica.
 *
 * @name GET /asistenciaCom/:nombreCom/:fecha
 * @param {Object} req - Objeto de solicitud HTTP que contiene el nombre del comedor y la fecha para buscar la asistencia.
 * @param {Object} res - Objeto de respuesta HTTP.
 * @returns {Object} - Respuesta HTTP con estado 200 (Éxito) y una tabla de información de asistencia de comensales si la solicitud se realiza correctamente,
 *                   - Respuesta HTTP con estado 400 (Solicitud incorrecta) si hay un error en la conexión a la base de datos.
 */
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


/**
 * Ruta para obtener información sobre la población de un comedor en una fecha específica.
 *
 * @name GET /poblacionCom/:nombreCom/:fecha
 * @param {Object} req - Objeto de solicitud HTTP que contiene el nombre del comedor y la fecha para buscar la población.
 * @param {Object} res - Objeto de respuesta HTTP.
 * @returns {Object} - Respuesta HTTP con estado 200 (Éxito) y una tabla de información sobre la población del comedor si la solicitud se realiza correctamente,
 *                   - Respuesta HTTP con estado 400 (Solicitud incorrecta) si hay un error en la conexión a la base de datos.
 */
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


/**
 * Ruta para obtener el historial de asistencia de un comedor.
 *
 * @name GET /historialAsis/:nombreCom
 * @param {Object} req - Objeto de solicitud HTTP que contiene el nombre del comedor para buscar el historial de asistencia.
 * @param {Object} res - Objeto de respuesta HTTP.
 * @returns {Object} - Respuesta HTTP con estado 200 (Éxito) y una tabla de historial de asistencia del comedor si la solicitud se realiza correctamente,
 *                   - Respuesta HTTP con estado 400 (Solicitud incorrecta) si hay un error en la conexión a la base de datos.
 */
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


/**
 * Ruta para obtener el historial de raciones donadas a un comedor.
 *
 * @name GET /racionesDonadas/:nombreCom
 * @param {Object} req - Objeto de solicitud HTTP que contiene el nombre del comedor para buscar el historial de raciones donadas.
 * @param {Object} res - Objeto de respuesta HTTP.
 * @returns {Object} - Respuesta HTTP con estado 200 (Éxito) y una tabla de historial de raciones donadas al comedor si la solicitud se realiza correctamente,
 *                   - Respuesta HTTP con estado 400 (Solicitud incorrecta) si hay un error en la conexión a la base de datos.
 */
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


/**
 * Ruta para obtener un reporte de incidencias en una fecha específica.
 *
 * @name GET /reporteIncidencia/:fecha
 * @param {Object} req - Objeto de solicitud HTTP que contiene la fecha para buscar el reporte de incidencias.
 * @param {Object} res - Objeto de respuesta HTTP.
 * @returns {Object} - Respuesta HTTP con estado 200 (Éxito) y una tabla de reporte de incidencias si la solicitud se realiza correctamente,
 *                   - Respuesta HTTP con estado 400 (Solicitud incorrecta) si hay un error en la conexión a la base de datos.
 */
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


/**
 * Ruta para obtener información sobre las condiciones de los comensales.
 *
 * @name GET /condicionComensal
 * @param {Object} req - Objeto de solicitud HTTP.
 * @param {Object} res - Objeto de respuesta HTTP.
 * @returns {Object} - Respuesta HTTP con estado 200 (Éxito) y una tabla de información sobre las condiciones de los comensales si la solicitud se realiza correctamente,
 *                   - Respuesta HTTP con estado 400 (Solicitud incorrecta) si hay un error en la conexión a la base de datos.
 */
app.get('/condicionComensal', async(req, res) => {
  try {
    const pool = await mssql.connect(dbConfig);
    const request = pool.request();
    const result = await request.execute('PROC_CCondicion');
    const table = result.recordset;
    
    return res.status(200).send({table});
    
  } catch (err) {
    return res.status(400).json({message: 'Error en la conexión a la BD'});
  }
});


/**
 * Ruta para obtener información del panel de control de un comedor en una fecha específica.
 *
 * @name GET /dashBoard/:nombreCom/:fecha
 * @param {Object} req - Objeto de solicitud HTTP.
 * @param {Object} res - Objeto de respuesta HTTP.
 * @param {string} req.params.nombreCom - El nombre del comedor del cual se desea obtener información del panel de control.
 * @param {string} req.params.fecha - La fecha en la que se desea obtener información del panel de control.
 * @returns {Object} - Respuesta HTTP con estado 200 (Éxito) y una tabla de información del panel de control si la solicitud se realiza correctamente,
 *                   - Respuesta HTTP con estado 400 (Solicitud incorrecta) si hay un error en la conexión a la base de datos.
 */
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
    return res.status(400).json({message: 'Error en la conexón a la BD'});
  }
});


/**
 * Ruta para obtener el menú de un comedor en una fecha específica.
 *
 * @name GET /verMenu/:nombreCom/:fecha
 * @param {Object} req - Objeto de solicitud HTTP.
 * @param {Object} res - Objeto de respuesta HTTP.
 * @param {string} req.params.nombreCom - El nombre del comedor del cual se desea obtener el menú.
 * @param {string} req.params.fecha - La fecha para la cual se desea obtener el menú.
 * @returns {Object} - Respuesta HTTP con estado 200 (Éxito) y una tabla de menú si la solicitud se realiza correctamente,
 *                   - Respuesta HTTP con estado 400 (Solicitud incorrecta) si hay un error en la conexión a la base de datos.
 */
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
    return res.status(400).json({message: 'Error en la conexón a la BD'});
  }
});


/**
 * Ruta para obtener los nombres de los comedores.
 *
 * @name GET /nombreComedores
 * @param {Object} req - Objeto de solicitud HTTP.
 * @param {Object} res - Objeto de respuesta HTTP.
 * @returns {Object} - Respuesta HTTP con estado 200 (Éxito) y una tabla de nombres de comedores si la solicitud se realiza correctamente,
 *                   - Respuesta HTTP con estado 400 (Solicitud incorrecta) si hay un error en la conexión a la base de datos.
 */
app.get('/nombreComedores', async(req, res) => {
  try {
    const pool = await mssql.connect(dbConfig);
    
    const request = pool.request();
    const result = await request.execute('PROC_CNombresCom');
    const table = result.recordset;
    
    return res.status(200).send({table});
    
  } catch (err) {
    return res.status(400).json({message: 'Error en la conexión a la BD'});
  }
});


/**
 * Ruta para obtener el estado de un comedor.
 *
 * @name GET /estadoCom/:nombreCom
 * @param {Object} req - Objeto de solicitud HTTP con un parámetro en la URL (nombreCom).
 * @param {Object} res - Objeto de respuesta HTTP.
 * @returns {Object} - Respuesta HTTP con estado 200 (Éxito) y una tabla que contiene el estado del comedor si la solicitud se realiza correctamente,
 *                   - Respuesta HTTP con estado 400 (Solicitud incorrecta) si hay un error en la conexión a la base de datos.
 */
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
    return res.status(400).json({message: 'Error en la conexón a la BD'});
  }
});


/*---------------------- APLICACIÓN Y PÁGINA 404 -----------------------------*/

/**
 * Middleware para manejar rutas no encontradas (404 - Not Found).
 * Este middleware se ejecutará cuando no se encuentre ninguna ruta coincidente con la solicitud.
 *
 * 
 */
app.use((req, res) => {
  res.type('text/plain').status(404).send('404 - Not Found');
});


/**
 * Iniciar el servidor HTTPS.
 * El servidor se inicia en el puerto y dominio especificados y escuchará las solicitudes HTTPS.
 */
httpsServer.listen(port, () => console.log(
  `Express started on https://${domain}:${port}`
  + '\nPress Ctrl-C to terminate.'));
