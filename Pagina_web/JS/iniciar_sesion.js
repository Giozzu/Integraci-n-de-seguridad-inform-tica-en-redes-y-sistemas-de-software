// Autor: Ángel Armando Márquez Curiel


/*************************
  Boton para inciar sesion 
 *************************/

const ipAddr = 'https://platopatodose3.ddns.net:8080';

function iniciar_sesion() {
    const payLoad = JSON.stringify({
      nombreUsuario: usuario.value,
      contra: contrasena.value
    });
    const xhr = new XMLHttpRequest();
    xhr.onload = () => {
      console.log(xhr.responseText);

      if (xhr.responseText == 'OK') {
        window.location.href = 'Graficas_comedores.html';

      } else {
        cuadro_de_error.style.display = 'block';
      }
    };
    xhr.open('POST', `${ipAddr}/loginSupervisor`);
    xhr.setRequestHeader('Content-Type', 'application/json');
    xhr.send(payLoad);
}


