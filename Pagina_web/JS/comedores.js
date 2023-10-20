/**************************
 * Tabla de visualización *
 **************************/

const ipAddr = 'http://3.95.129.111:8080';

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


google.charts.load('current', {'packages':['table']});
google.charts.setOnLoadCallback(drawTable);

function drawTable() {
    const params = new URLSearchParams(window.location.search);
    const page = params.get('page') ?? 1;
    var data = new google.visualization.DataTable();
  
    const xhr = new XMLHttpRequest();
    const url = `${ipAddr}/comedoresInfo/${page}`;
    xhr.onload = () => {
    
        const jsonData = JSON.parse(xhr.responseText);
        data.addColumn('number', 'ID Comedor');
        data.addColumn('string', 'Correo');
        data.addColumn('string', 'Estado (abierto, cerrado)');
        data.addColumn('string', 'Nombre');
        data.addColumn('number', 'Capacidad');
        data.addColumn('string', 'Dirección');
        data.addColumn('string', 'Telefono');
        jsonData.table.forEach((row) => {
        data.addRow([row.IDComedor, row.Correo, row.Estado, row.Nombre, row.Capacidad, row.Direccion, row.Telefono]);
        });

        const formatter = new google.visualization.NumberFormat({pattern: '0'});
        formatter.format(data, 4);

        var table = new google.visualization.Table(document.getElementById('table_div'));

        table.draw(data, {showRowNumber: false, width: '100%', height: '100%', color: 'blue'});
    }
  xhr.open('GET', url);
  xhr.send();
}
/****************************
 * Agregar, actualizar, etc *
 ****************************/
function agregar_comedor() {
    correoEmp = com_correo_agregar.value,
    estadoCom = "Cerrado",
    nombre = com_nombre_agregar.value,
    capacidad = com_capacidad_agregar.value,
    dir = com_direccion_agregar.value,
    tel = com_telefono_agregar.value
    
    if (correoEmp && estadoCom && nombre && capacidad && dir && tel) {
        const payLoad = JSON.stringify({
            correoEmp, estadoCom, nombre,
            capacidad, dir, tel
        });
        console.log(payLoad)
        const xhr = new XMLHttpRequest();
        xhr.onload = () => {
            console.log(xhr.responseText);
            if (xhr.responseText == 'Comedor agregado') {
                window.alert(xhr.responseText);
                drawTable();
            }
          };
        xhr.open('POST', '/insertaComedor');
        xhr.setRequestHeader('Content-Type', 'application/json');
        xhr.send(payLoad);
        
    } else {
        window.alert("Ingresa correctamente los datos");
    }
}

function actualizar_comedor() {
    idCom = com_id_actualizar.value,
    correoEmp = com_correo_actualizar.value
    estadoCom = com_estado_actualizar.value
    nombre = com_nombre_actualizar.value
    capacidad = com_capacidad_actualizar.value
    dir = com_direccion_actualizar.value
    tel = com_telefono_actualizar.value
    
    if (idCom && correoEmp && estadoCom && nombre && capacidad && dir && tel) {
        const payLoad = JSON.stringify({
            idCom, correoEmp, estadoCom, 
            nombre, capacidad, dir, tel
        });
        console.log(payLoad)
        const xhr = new XMLHttpRequest();
        xhr.onload = () => {
            console.log(xhr.responseText);
            if (xhr.responseText == 'Comedor actualizado') {
                window.alert(xhr.responseText);
                drawTable();
            }
          };
        xhr.open('PUT', '/actualizaComedor');
        xhr.setRequestHeader('Content-Type', 'application/json');
        xhr.send(payLoad);
        
    } else {
        window.alert("Ingresa correctamente los datos");
    }
}