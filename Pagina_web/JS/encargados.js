// Autor: Ángel Armando Márquez Curiel

/***********************************************
 * Cambiar página en la tabla de visualización *
 ***********************************************/

const ipAddr = 'https://platopatodose3.ddns.net:8080';

function cambiarPagina(n) {
  const params = new URLSearchParams(window.location.search);
  let page = parseInt(params.get('page') ?? 1);
  page += n;
  if (page < 1) {
    page = 1;
  }
  params.set('page', page);
  const newUrl = window.location.pathname + '?' + params.toString();
  history.pushState({}, '', newUrl);
  drawTable();
}


/****************************************
 * Tabla de visualización de encargados *
 ****************************************/

google.charts.load('current', {'packages':['table']});
google.charts.setOnLoadCallback(drawTable);

function drawTable() {
  const params = new URLSearchParams(window.location.search);
  const page = params.get('page') ?? 1;
  var data = new google.visualization.DataTable();
  
  const xhr = new XMLHttpRequest();
  const url = `${ipAddr}/encargadosInfo/${page}`;
  xhr.onload = () => {
    
    const jsonData = JSON.parse(xhr.responseText);
    data.addColumn('number', 'IDEmpleado');
    data.addColumn('string', 'Nombre');
    data.addColumn('string', 'Apellido Paterno');
    data.addColumn('string', 'Apellido Materno');
    data.addColumn('number', 'Fecha de Nacimiento');
    data.addColumn('string', 'Sexo');
    data.addColumn('string', 'Correo');
    data.addColumn('string', 'Nombre de Usuario');
    jsonData.table.forEach((row) => {
      data.addRow([row.IDEmpleado, row.Nombre, row.ApellidoP, row.ApellidoM, row.FechaNacim, row.Sexo, row.Correo, row.NombreUsuario]);
    });

    const formatter = new google.visualization.NumberFormat({pattern: '0'});
    formatter.format(data, 4);

    var table = new google.visualization.Table(document.getElementById('table_div'));

    table.draw(data, {showRowNumber: false, width: '100%', height: '100%', color: 'blue'});
  }
  xhr.open('GET', url);
  xhr.send();
}

/*********************
 * Agregar encargado *
 *********************/

function agregar_encargado() {
  nombre = enc_nombres_agregar.value,
  apellidoP = enc_paterno_agregar.value,
  apellidoM = enc_materno_agregar.value,
  fechaNacim = enc_nacimiento_agregar.value,
  sexo = enc_sexo_agregar.value
  correo = enc_correo_agregar.value
  nombreUsuario = enc_usuario_agregar.value,
  contra = enc_contra_agregar.value
  console.log(sexo)
  if (nombre && apellidoP && apellidoM && fechaNacim && sexo && correo && nombreUsuario && contra) {
      const payLoad = JSON.stringify({
          nombre, apellidoP, apellidoM,
          fechaNacim, sexo, correo, nombreUsuario, contra
      });
      console.log(payLoad)
      const xhr = new XMLHttpRequest();
      xhr.onload = () => {
          console.log(xhr.responseText);
          if (xhr.responseText == 'Encargado agregado') {
              window.alert(xhr.responseText);
              drawTable();
          }
        };
      xhr.open('POST', '/insertaEncargado');
      xhr.setRequestHeader('Content-Type', 'application/json');
      xhr.send(payLoad);
      
  } else {
      window.alert("Ingresa correctamente los datos");
  }
}

/************************
 * Actualizar encargado *
 ************************/

function actualizar_empleado() {
  idEmp = enc_id_actualizar.value,
  nombre = enc_nombres_actualizar.value,
  apellidoP = enc_paterno_actualizar.value,
  apellidoM = enc_materno_actualizar.value,
  fechaNacim = enc_nacimiento_actualizar.value,
  sexo = enc_sexo_actualizar.value,
  correo = enc_correo_actualizar.value,
  nombreUsuario = enc_usuario_actualizar.value
  
  if (idEmp && nombre && apellidoP && apellidoM && fechaNacim && sexo && correo && nombreUsuario) {
      const payLoad = JSON.stringify({
          idEmp, nombre, apellidoP,
          apellidoM, fechaNacim, sexo, correo, nombreUsuario
      });
      console.log(payLoad)
      const xhr = new XMLHttpRequest();
      xhr.onload = () => {
          console.log(xhr.responseText);
          if (xhr.responseText == 'Empleado Actualizado') {
              window.alert(xhr.responseText);
              drawTable();
          }
        };
      xhr.open('PUT', '/actualizaEmpleado');
      xhr.setRequestHeader('Content-Type', 'application/json');
      xhr.send(payLoad);
      
  } else {
      window.alert("Ingresa correctamente los datos");
  }
}

/**************************************
 * Actualizar contraseña de encargado *
 **************************************/

function actualizar_contrasena() {
  idEmp = enc_idContra_actualizar.value,
  contra = enc_contra_actualizar.value
  
  if (idEmp && contra ) {
      const payLoad = JSON.stringify({
          idEmp, contra
      });
      console.log(payLoad)
      const xhr = new XMLHttpRequest();
      xhr.onload = () => {
          console.log(xhr.responseText);
          if (xhr.responseText == 'Contraseña actualizada') {
              window.alert(xhr.responseText);
              drawTable();
          }
        };
      xhr.open('PUT', '/actualizaContraEmp');
      xhr.setRequestHeader('Content-Type', 'application/json');
      xhr.send(payLoad);
      
  } else {
      window.alert("Ingresa correctamente los datos");
  }
}

