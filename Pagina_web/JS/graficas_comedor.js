
/******************************************
 * Cargar la información de los comedores *
 ******************************************/

const ipAddr = 'http://3.95.129.111:8080';
const hoy = new Date();
const anio = hoy.getFullYear();
const mes = (hoy.getMonth() + 1).toString().padStart(2, '0');
const dia = hoy.getDate().toString().padStart(2, '0');
const fechaFormato = `${anio}-${mes}-${dia}`;

google.charts.load('current', { 'packages': ['corechart', 'table'] });
google.charts.setOnLoadCallback(rellenarComedor);

function rellenarComedor() {
    var select = document.getElementById('comedorSelect');

    const xhr = new XMLHttpRequest();
    
    xhr.onload = function () {
        if (xhr.status >= 200 && xhr.status < 300) {
            const jsonData = JSON.parse(xhr.responseText);

            jsonData.table.forEach((row) => {
                const option = document.createElement('option');
                option.value = row.Nombre;
                option.textContent = row.Nombre;
                select.appendChild(option);
            });
        } else {
            console.error('Error al cargar los datos:', xhr.statusText);
        }
    };

    xhr.open('GET', `${ipAddr}/nombreComedores`);
    xhr.send();
}

document.addEventListener('DOMContentLoaded', function () {
    var select = document.getElementById('comedorSelect');

    var selectedValue = select.value;
    console.log(selectedValue);

    select.addEventListener('change', function () {
      asistenciaComedor();
      poblacionComedor();
      historialAsistencia();
      racionesDonadas();
      reporteEncuestas();
    });
});





/**********************
 * Asistencia Comedor *
 **********************/

google.charts.load('current', {'packages':['table']});
google.charts.setOnLoadCallback(asistenciaComedor);


function asistenciaComedor() { 
  const comedor = document.getElementById('comedorSelect').value;
  //const date = '2023-10-18';
  //const comedor = select;
  var data = new google.visualization.DataTable();
  const xhr = new XMLHttpRequest();
  const url = `${ipAddr}/asistenciaCom/${encodeURIComponent(comedor)}/${fechaFormato}`;
  xhr.onload = () => {
    const jsonData = JSON.parse(xhr.responseText);
    
    data.addColumn('string', 'Nombre');
    data.addColumn('number', 'Visita');
    jsonData.table.forEach((row) => {
      if (row.ApellidoM == null){
        var nombreCompleto = row.Nombre + ' ' + row.ApellidoP;
      } else {
        var nombreCompleto = row.Nombre + ' ' + row.ApellidoP + ' ' + row.ApellidoM;
      }
      data.addRow([nombreCompleto, row.Visita]);
      console.log(data);
    });



    var table = new google.visualization.Table(document.getElementById('mayor_asistencia'));

    table.draw(data, {showRowNumber: false, width: '100%', height: '100%', color: 'blue'});
  }
  xhr.open('GET', url);
  xhr.send()
}

/**********************
 * Población Comedor *
 **********************/

google.charts.load('current', {'packages':['corechart']});
google.charts.setOnLoadCallback(poblacionComedor);


function poblacionComedor() {
  const comedor = document.getElementById('comedorSelect').value;  
  const date = '2023-10-18';
  
  const xhr = new XMLHttpRequest();
  const url = `${ipAddr}/poblacionCom/${comedor}/${fechaFormato}`;
  xhr.onload = () => {
    const jsonData = JSON.parse(xhr.responseText);
    var data = google.visualization.arrayToDataTable([
      ['Sexo', 'Personas'],
      ['Mujer', jsonData.table[0].Mujer],
      ['Hombre', jsonData.table[0].Hombre]
    ]);
    var options = {
      title: 'Raciones pagadas y donadas',
      is3D: true,
      backgroundColor: 'transparent',
    };
  
    var chart = new google.visualization.PieChart(document.getElementById('porcentaje_poblacion'));
  
    chart.draw(data, options);
  }
  xhr.open('GET', url);
  xhr.send()
}

/***************************
 * Historial de Asistencia *
 ***************************/

google.charts.load('current', {'packages':['table']});
google.charts.setOnLoadCallback(historialAsistencia);


function historialAsistencia() {
  const comedor = document.getElementById('comedorSelect').value;
  var data = new google.visualization.DataTable();
  const xhr = new XMLHttpRequest();
  const url = `${ipAddr}/historialAsis/${encodeURIComponent(comedor)}`;
  xhr.onload = () => {
    const jsonData = JSON.parse(xhr.responseText);
    
    data.addColumn('string', 'Nombre');
    data.addColumn('number', 'Visitas');
    jsonData.table.forEach((row) => {
      if (row.ApellidoM == null){
        var nombreCompleto = row.Nombre + ' ' + row.ApellidoP;
      } else {
        var nombreCompleto = row.Nombre + ' ' + row.ApellidoP + ' ' + row.ApellidoM;
      }
      data.addRow([nombreCompleto, row.Visita]);
      
    });

    var table = new google.visualization.Table(document.getElementById('asistencias_totales'));

    table.draw(data, {showRowNumber: false, width: '100%', height: '100%', color: 'blue'});
  }
  xhr.open('GET', url);
  xhr.send()
}

/**************************
 **** Raciones Donadas ****
 **************************/

google.charts.load('current', {'packages':['corechart']});
google.charts.setOnLoadCallback(racionesDonadas);


function racionesDonadas() {
  const comedor = document.getElementById('comedorSelect').value;
  var data = new google.visualization.DataTable();
  const xhr = new XMLHttpRequest();
  const url = `${ipAddr}/racionesDonadas/${encodeURIComponent(comedor)}`;
  xhr.onload = () => {
    const jsonData = JSON.parse(xhr.responseText);
    
    data.addColumn('string', 'Nombre');
    data.addColumn('string', 'CURP');
    jsonData.table.forEach((row) => {
      if (row.ApellidoM == null){
        var nombreCompleto = row.Nombre + ' ' + row.ApellidoP;
      } else {
        var nombreCompleto = row.Nombre + ' ' + row.ApellidoP + ' ' + row.ApellidoM;
      }
      data.addRow([nombreCompleto, row.CURP]);
      console.log(data);
    });

    var table = new google.visualization.Table(document.getElementById('raciones_donadas'));

    table.draw(data, {showRowNumber: false, width: '100%', height: '100%', color: 'blue'});
  }
  xhr.open('GET', url);
  xhr.send()
}


/**********************************
 ****** Reporte de Encuestas ******
 **********************************/

google.charts.load('current', {'packages':['table']});
google.charts.setOnLoadCallback(reporteEncuestas);

function reporteEncuestas() {
  //const comedor = '5 de Mayo';
  const comedor = document.getElementById('comedorSelect').value;
  //const date = '2023-10-18';
  //const comedor = select;
  var data = new google.visualization.DataTable();
  const xhr = new XMLHttpRequest();
  const url = `${ipAddr}/encuesta/${encodeURIComponent(comedor)}/${fechaFormato}`;
  xhr.onload = () => {
    const jsonData = JSON.parse(xhr.responseText);
    
    data.addColumn('string', 'Pregunta');
    data.addColumn('string', 'Comentarios');
    data.addColumn('number', 'Calificacion');
    jsonData.table.forEach((row) => {
      data.addRow([row.Pregunta, row.Comentarios, row.Calificacion]);
      console.log(data);
    });

    var table = new google.visualization.Table(document.getElementById('encuestas'));

    table.draw(data, {showRowNumber: false, width: '100%', height: '100%', color: 'blue'});
  }
  xhr.open('GET', url);
  xhr.send()
}