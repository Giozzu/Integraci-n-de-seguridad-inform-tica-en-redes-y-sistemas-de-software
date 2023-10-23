// Autor: Ángel Armando Márquez Curiel

/**********************************
 * Cambiar pagina de supervisores *
 **********************************/

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



/**************************
 * Tabla de visualización *
 **************************/

google.charts.load('current', {'packages':['table']});
google.charts.setOnLoadCallback(drawTable);

function drawTable() {
  const params = new URLSearchParams(window.location.search);
  const page = params.get('page') ?? 1;
  var data = new google.visualization.DataTable();
  const xhr = new XMLHttpRequest();
  const url = `${ipAddr}/supervisoresInfo/${page}`;
  xhr.onload = () => {
    
    const jsonData = JSON.parse(xhr.responseText);
    data.addColumn('number', 'IDEmpleado');
    data.addColumn('string', 'Nombre');
    data.addColumn('string', 'Apellido Paterno');
    data.addColumn('string', 'Apellido Materno');
    data.addColumn('number', 'Fecha de Nacimiento');
    data.addColumn('string', 'Sexo');
    data.addColumn('string', 'Nombre de Usuario');
    jsonData.table.forEach((row) => {
      data.addRow([row.IDEmpleado, row.Nombre, row.ApellidoP, row.ApellidoM, row.FechaNacim, row.Sexo, row.NombreUsuario]);
    });

    const formatter = new google.visualization.NumberFormat({pattern: '0'});
    formatter.format(data, 4);

    var table = new google.visualization.Table(document.getElementById('table_div'));

    table.draw(data, {showRowNumber: false, width: '100%', height: '100%', color: 'blue'});
  }
  xhr.open('GET', url);
  xhr.send();
}

/**********************
 * Agregar supervisor *
 **********************/

function agregar_supervisor() {
    nombre = sup_nombres_agregar.value,
    apellidoP = sup_paterno_agregar.value,
    apellidoM = sup_materno_agregar.value,
    fechaNacim = sup_nacimiento_agregar.value,
    sexo = sup_sexo_agregar.value,
    correo = sup_correo_agregar.value,
    nombreUsuario = sup_usuario_agregar.value,
    contra = sup_contra_agregar.value
    
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
            if (xhr.responseText == 'Supervisor agregado') {
                window.alert(xhr.responseText);
            }
          };
        xhr.open('POST', '/insertaSupervisor');
        xhr.setRequestHeader('Content-Type', 'application/json');
        xhr.send(payLoad);
        
    } else {
        window.alert("Ingresa correctamente los datos");
    }
}

/*************************
 * Actualizar supervisor *
 *************************/

function actualizar_supervisor() {
    idEmp = sup_id_actualizar.value,
    nombre = sup_nombres_actualizar.value,
    apellidoP = sup_paterno_actualizar.value,
    apellidoM = sup_materno_actualizar.value,
    fechaNacim = sup_nacimiento_actualizar.value,
    sexo = sup_sexo_actualizar.value,
    correo = sup_correo_actualizar.value,
    nombreUsuario = sup_usuario_actualizar.value
    
    console.log(sexo)
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
            }
          };
        xhr.open('PUT', '/actualizaEmpleado');
        xhr.setRequestHeader('Content-Type', 'application/json');
        xhr.send(payLoad);
        
    } else {
        window.alert("Ingresa correctamente los datos");
    }
}

/****************************************
 * Actualizar contrasenia de supervisor *
 ****************************************/

function actualizar_contrasena() {
    idEmp = sup_idContra_actualizar.value,
    contra = sup_contra_actualizar.value
    
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
            }
          };
        xhr.open('PUT', '/actualizaContraEmp');
        xhr.setRequestHeader('Content-Type', 'application/json');
        xhr.send(payLoad);
        
    } else {
        window.alert("Ingresa correctamente los datos");
    }
}

/***********************
 * Eliminar supervisor *
 ***********************/

function eliminar_empleado() {
    nombre = sup_nombre_baja.value
    if (nombre) {
        const payLoad = JSON.stringify({
            nombre
        });
        console.log(payLoad)
        const xhr = new XMLHttpRequest();
        xhr.onload = () => {
            console.log(xhr.responseText);
            if (xhr.responseText == 'El Empleado se ha borrado') {
                window.alert(xhr.responseText);
            }
          };
        xhr.open('DELETE', '/eliminaEmpleado');
        xhr.setRequestHeader('Content-Type', 'application/json');
        xhr.send(payLoad);
        
    } else {
        window.alert("Ingresa correctamente los datos");
    }
}

