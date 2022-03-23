var bodyTable = document.getElementById('bodyTable')

/* CONEXION */


var url = "http://localhost:4000";

function verifyConnection(){
    fetch(url + "/cliente").then(function(res) {
        return res.json();
    }).then(function (json) {
        console.log(json[0].ID_CLIENTE);
    })
}

    fetch(url + "/verRegistro").then(function(res) {
        return res.json();
    }).then(function (json) {
        const body = document.getElementById('bodyTable');
        
        var count = Object.keys(json).length
        for (var i = 0; i < count ; i++) {

            var hilera = document.createElement("tr");

            var celda1 = document.createElement("td");
            var textoCelda1 = document.createTextNode(json[i].ID_REGISTRO);
            celda1.appendChild(textoCelda1);
            var celda2 = document.createElement("td");
            var textoCelda2 = document.createTextNode(json[i].ID_CLIENTE);
            celda2.appendChild(textoCelda2);
            var celda3 = document.createElement("td");
            var textoCelda3 = document.createTextNode(json[i].NUMERO_CUENTA);
            celda3.appendChild(textoCelda3);
            var celda4 = document.createElement("td");
            var textoCelda4 = document.createTextNode(json[i].ID_BANCO);
            celda4.appendChild(textoCelda4);
            var celda5 = document.createElement("td");
            var textoCelda5 = document.createTextNode(json[i].MONTO);
            celda5.appendChild(textoCelda5);
            var celda6 = document.createElement("td");
            var textoCelda6 = document.createTextNode(json[i].DIVISA);
            celda6.appendChild(textoCelda6);
            var celda7 = document.createElement("td");
            var textoCelda7 = document.createTextNode(json[i].TIPO);
            celda7.appendChild(textoCelda7);
            hilera.appendChild(celda1);
            hilera.appendChild(celda2);
            hilera.appendChild(celda3);
            hilera.appendChild(celda4);
            hilera.appendChild(celda5);
            hilera.appendChild(celda6);
            hilera.appendChild(celda7);
            
        
            // agrega la hilera al final de la tabla (al final del elemento tblbody)
            body.appendChild(hilera);
          }
    })

