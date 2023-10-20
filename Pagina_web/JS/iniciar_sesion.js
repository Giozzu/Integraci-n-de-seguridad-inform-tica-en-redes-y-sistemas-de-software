const ipAdd = "http://3.95.129.111:8080"

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
    xhr.open('POST', `${ipAdd}/loginSupervisor`);
    xhr.setRequestHeader('Content-Type', 'application/json');
    xhr.send(payLoad);
}


