

var url = "http://localhost:3000";

/* REGISTER MOVEMENTS */

var tableRegisterMovements = document.getElementById('registerMovements')

function genera_tabla(number) {
    // Crea las celdas
    
  }


  function verifyConnection(){
    fetch(url + "/init").then(function(res) {
        return res.json();
    }).then(function (json) {
        var count = Object.keys(json).length
        for (var i = 0; i < count; i++) {
          var hilera = document.createElement("tr");

            var celda1 = document.createElement("td");
            var textoCelda1 = document.createTextNode(json[0].cod);
            celda1.appendChild(textoCelda1);

            var celda2 = document.createElement("td");
            var textoCelda2 = document.createTextNode(json[0].Type);
            celda2.appendChild(textoCelda2);

            var celda3 = document.createElement("td");
            var textoCelda3 = document.createTextNode(json[0].status);
            celda3.appendChild(textoCelda3);

            hilera.appendChild(celda1);
            hilera.appendChild(celda2);
            hilera.appendChild(celda3);
          
      
          // agrega la hilera al final de la tabla (al final del elemento tblbody)
          tableRegisterMovements.appendChild(hilera);
        }
    })
}


document.getElementById('init').addEventListener("click", 
(evt) => {
    evt.preventDefault();
    verifyConnection();
})