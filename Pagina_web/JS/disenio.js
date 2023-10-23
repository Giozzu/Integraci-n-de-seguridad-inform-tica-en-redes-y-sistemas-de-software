// Autor: Ángel Armando Márquez Curiel

/*****************************************************************************************
 * Observa el movimiento en el mouse para mostrar un circulo donde se encuentre el mouse *
 *****************************************************************************************/

document.body.addEventListener("mousemove", (event) => {
  const { clientX, clientY } = event;

  gsap.set(".cursor", {
    x: clientX,
    y: clientY,
  });

  gsap.to(".shape", {
    x: clientX,
    y: clientY,
    stagger: -0.1
  });
});