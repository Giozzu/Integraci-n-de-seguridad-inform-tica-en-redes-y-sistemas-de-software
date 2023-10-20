/*********************************
 ************ Columnas *********** 
 *********************************/
 
 const ipAddr = 'http://3.95.129.111:8080';
 
const hoy = new Date();
const anio = hoy.getFullYear();
const mes = (hoy.getMonth() + 1).toString().padStart(2, '0');
const dia = hoy.getDate().toString().padStart(2, '0');
const fechaFormato = `${anio}-${mes}-${dia}`;
console.log(fechaFormato)
 
 google.charts.load("current", {packages:['corechart']});
 google.charts.setOnLoadCallback(drawChart5);
 
 function drawChart5() {
   const xhr = new XMLHttpRequest();
   const url = `${ipAddr}/mayorAsisCom/${fechaFormato}`;
   xhr.onload = () => { 
     const jsonData = JSON.parse(xhr.responseText);
     var array = [['Nombre', 'Visitas', { role: 'style' }]];
     for (var i = 0; i < jsonData.table.length; i++) {
       array.push([jsonData.table[i].Nombre, jsonData.table[i].Visitas, '#706C6Dff']);
     }
   
     var data = google.visualization.arrayToDataTable(array);
 
     var view = new google.visualization.DataView(data);
     view.setColumns([0, 1, { calc: "stringify", sourceColumn: 1, type: "string", role: "annotation" }]);
 
     var options = {
       title: "Visitas en comedores",
       width: "100%",
       height: 400,
       bar: {groupWidth: "95%"},
       legend: { position: "none" },
       backgroundColor: 'transparent',
     };
     var chart = new google.visualization.ColumnChart(document.getElementById("columnchart_values"));
     chart.draw(view, options);
   }
   xhr.open('GET', url);
   xhr.send(); 
 }


/**********************************
 ************ Pie Chart *********** 
 **********************************/

google.charts.load("current", {packages:["corechart"]});
google.charts.setOnLoadCallback(raciones);

function raciones() {
  const xhr = new XMLHttpRequest();
  const url = `${ipAddr}/racionesPagDon/${fechaFormato}`;
  xhr.onload = () => {
    const jsonData = JSON.parse(xhr.responseText);
    var data = google.visualization.arrayToDataTable([
      ['Comida', 'Raciones'],
      ['Pagada', jsonData.table[0].Pagada],
      ['Donada', jsonData.table[0].Donada]
    ]);
    var options = {
      title: 'Raciones pagadas y donadas',
      is3D: true,
      backgroundColor: 'transparent',
    };
  
    var chart = new google.visualization.PieChart(document.getElementById('piechart_raciones'));
  
    chart.draw(data, options);
  }
  xhr.open('GET', url);
  xhr.send()
}

/************************************
 ************ Pie Chart 2 *********** 
 ************************************/

 google.charts.load("current", {packages:["corechart"]});
 google.charts.setOnLoadCallback(gruposEdades);
 
 function gruposEdades() {
   const xhr = new XMLHttpRequest();
   const url = `${ipAddr}/grupoEdades/${fechaFormato}`;
   xhr.onload = () => {
     const jsonData = JSON.parse(xhr.responseText);
     var array = [['Rango de edad', 'Personas', { role: 'style' }]];
     for (var i = 0; i < jsonData.table.length; i++) {
       array.push([jsonData.table[i].RangoEdades, jsonData.table[i].Cantidad, '#706C6Dff']);
     }

     var data = google.visualization.arrayToDataTable(array);
     var options = {
       title: 'Grupos de edades',
       is3D: true,
       backgroundColor: 'transparent',
     };
   
     var chart = new google.visualization.PieChart(document.getElementById('piechart_gruosEdades'));
   
     chart.draw(data, options);
   }
   xhr.open('GET', url);
   xhr.send()
 }


 /***********************************
 ************ Pie Chart 3 *********** 
 ************************************/

 google.charts.load("current", {packages:["corechart"]});
 google.charts.setOnLoadCallback(condiciones);
 
 function condiciones() {
   const xhr = new XMLHttpRequest();
   const url = `${ipAddr}/condiciones/${fechaFormato}`;
   xhr.onload = () => {
     const jsonData = JSON.parse(xhr.responseText);
     var array = [['Condicion', 'Personas', { role: 'style' }]];
     for (var i = 0; i < jsonData.table.length; i++) {
       array.push([jsonData.table[i].Nombre, jsonData.table[i].Veces, '#706C6Dff']);
     }

     var data = google.visualization.arrayToDataTable(array);
     var options = {
       title: 'Grupos Demográficos',
       is3D: true,
       backgroundColor: 'transparent',
     };
   
     var chart = new google.visualization.PieChart(document.getElementById('piechart_gruposDemograficos'));
   
     chart.draw(data, options);
   }
   xhr.open('GET', url);
   xhr.send()
 }

 
/************************************
 ****** Reporte de Incidencias ******
 ************************************/

google.charts.load('current', {'packages':['table']});
google.charts.setOnLoadCallback(reporteIncidencia);


function reporteIncidencia() {
  //const date = '2023-10-18';
  var data = new google.visualization.DataTable();
  const xhr = new XMLHttpRequest();
  const url = `${ipAddr}/reporteIncidencia/${fechaFormato}`;
  xhr.onload = () => {
    const jsonData = JSON.parse(xhr.responseText);
    
    data.addColumn('string', 'Comedor');
    data.addColumn('string', 'Tipo');
    data.addColumn('string', 'Descripcion');
    data.addColumn('string', 'Fecha');
    jsonData.table.forEach((row) => {
      data.addRow([row.Comedor, row.Tipo, row.Descripcion, row.Fecha]);
      console.log(data);
    });

    var table = new google.visualization.Table(document.getElementById('incidencias'));

    table.draw(data, {showRowNumber: false, width: '100%', height: '100%', color: 'blue'});
  }
  xhr.open('GET', url);
  xhr.send()
}


