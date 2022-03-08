
const jsonMoves = require('./movements.json');
var url = "http://localhost:3000";

/* REGISTER MOVEMENTS */

var tableRegisterMovements = document.getElementById('registerMovements')

function genera_tabla(number) {
    // Crea las celdas
    console.log(jsonMoves);
    for (var i = 0; i < number; i++) {
      var hilera = document.createElement("tr");
  
      for (var j = 0; j < 3; j++) {
        var celda = document.createElement("td");
        var textoCelda = document.createTextNode("celda en la hilera "+i+", columna "+j);
        celda.appendChild(textoCelda);
        hilera.appendChild(celda);
      }
  
      // agrega la hilera al final de la tabla (al final del elemento tblbody)
      tableRegisterMovements.appendChild(hilera);
    }
  }

document.getElementById('init').addEventListener("click", 
(evt) => {
    evt.preventDefault();
    genera_tabla(3);
})