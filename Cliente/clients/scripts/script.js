/* ANIMATION */

var createClient = document.getElementById("createClient"),
    editClient = document.getElementById("editClient"),
    clients = document.getElementById("clients"),
    overlay1 = document.getElementById("overlay1"),
    overlay2 = document.getElementById("overlay2"),
    overlay3 = document.getElementById("overlay3"),
    popup1 = document.getElementById("popup1"),
    popup2 = document.getElementById("popup2"),
    popup3 = document.getElementById("popup3"),
    cerrarPopup1 = document.getElementById("cerrarPopup1"),
    cerrarPopup2 = document.getElementById("cerrarPopup2"),
    cerrarPopup3 = document.getElementById("cerrarPopup3");
    


createClient.addEventListener('click', function() {
    overlay1.classList.add('active');
    popup1.classList.add('active');
});

editClient.addEventListener('click', function(){
    overlay2.classList.add('active');
    popup2.classList.add('active');
});

clients.addEventListener('click', function () {
    overlay3.classList.add('active');
    popup3.classList.add('active');
});

cerrarPopup1.addEventListener('click', function() {
    overlay1.classList.remove('active');
    popup1.classList.remove('active');
});

cerrarPopup2.addEventListener('click', function() {
    overlay2.classList.remove('active');
    popup2.classList.remove('active');
    location.reload()
});

cerrarPopup3.addEventListener('click', function() {
    overlay3.classList.remove('active');
    popup3.classList.remove('active');
    location.reload()
});

/* CONEXION */


var url = "http://localhost:4000";

function verifyConnection(){
    fetch(url + "/cliente").then(function(res) {
        return res.json();
    }).then(function (json) {
        console.log(json[0].ID_CLIENTE);
    })
}

/* HACER CONSECUTIVO */
var consecutivo = []

    fetch(url + "/verCliente").then(function(res) {
        return res.json();
    }).then(function (json) {        
        const body = document.getElementById('codCliente');
        body.innerHTML = ''
        var count = Object.keys(json).length
        for (let index = 00000; index < 00100; index++) {
            if(10>index & index >= 0){
                consecutivo.push("0000" + index)
            }else{
                consecutivo.push("000" + index)
            }
            
        }
        for (var i = 0; i < count ; i++) {  
            for (let index = 00000; index < 00050; index++) {
                console.log(consecutivo[index])
                if(json[i].ID_CLIENTE == consecutivo[index]){
                    consecutivo.splice(index,1)
                }
            }
        }
        for (let index = 0; index < consecutivo.length; index++) {
            var option = document.createElement("option")
            var textoOption = document.createTextNode(consecutivo[index]);
            option.appendChild(textoOption);
            body.appendChild(option);
        }
    })


/* CREAR CLIENTE */
    

function crearCliente(){
    fetch(url + "/crearCliente", {
        method: 'POST',
        body: JSON.stringify({
            ID_CLIENTE: document.getElementById('codCliente').value ,
            NOMBRES: document.getElementById('nombres').value,
            APELLIDOS: document.getElementById('apellidos').value,
            FECHA_NACIMIENTO: document.getElementById('fecha').value,
            TIPO_DOCUMENTO: 'CC',
            NUMERO_DOCUMENTO: document.getElementById('No documento').value,
            DIRECCION: document.getElementById('direccion').value,
            ESTADO_CLIENTE: 'A'
        }),
        headers: {
            'Accept': 'application/json',
            'Content-Type': 'application/json'
        }
    }).then(res => res.json())
    .catch(error => console.error('Error: ', error))
    .then(response => {
        return console.log('Success: ', response);
    })
}

document.getElementById("saveCreateClient").addEventListener("click", 
(evt) => {
    evt.preventDefault();
    crearCliente();
})

/* EDITAR CLIENTE */

/* MOSTRAR CLIENTES EN EL SELECTOR DE EDTIAR */

function mostrarEditarClientes(){
    fetch(url + "/verCliente").then(function(res) {
        return res.json();
    }).then(function (json) {
        const body = document.getElementById('ClientList');
        var count = Object.keys(json).length
        for (let index = 0; index < count; index++) {
            var option = document.createElement("option")
            var textoOption = document.createTextNode(json[index].ID_CLIENTE +" - "+ json[index].NOMBRES);
            option.appendChild(textoOption);
            body.appendChild(option);
        }
    })
}

document.getElementById('editClient').addEventListener("click", 
(evt) => {
    evt.preventDefault();
    mostrarEditarClientes();
})


var editCodClient = 000;

function opcionSeleccionadEditar() {
    const indice = document.getElementById('ClientList').selectedIndex;
    if(indice === -1) return; // Esto es cuando no hay elementos
    const opcionSeleccionada = document.getElementById('ClientList').options[indice].text;
    editCodClient = opcionSeleccionada.substr(0,5)
  };

document.getElementById('ClientList').addEventListener("change",
(evt) => {
    evt.preventDefault();
    opcionSeleccionadEditar();
})

/* MANDAR DATOS PARA EDITAR */

function editarCliente(){
    fetch(url + "/editarCliente", {
        method: 'POST',
        body: JSON.stringify({
            ID_CLIENTE: editCodClient,
            NOMBRES: document.getElementById('editName').value,
            APELLIDOS: document.getElementById('editLastName').value,
            FECHA_NACIMIENTO: document.getElementById('editBirth').value,
            TIPO_DOCUMENTO: 'CC',
            NUMERO_DOCUMENTO: document.getElementById('editNoDoc').value,
            DIRECCION: document.getElementById('editAddress').value,
            ESTADO_CLIENTE: 'A'
        }),
        headers: {
            'Accept': 'application/json',
            'Content-Type': 'application/json'
        }
    }).then(res => res.json())
    .catch(error => console.error('Error: ', error))
    .then(response => {
        return console.log('Success: ', response);
    })
}

document.getElementById("btnEditarCliente").addEventListener("click", 
(evt) => {
    evt.preventDefault();
    editarCliente();
})

/* MOSTRAR CLIENTE */

function mostrarClientes(){
    fetch(url + "/verCliente").then(function(res) {
        return res.json();
    }).then(function (json) {
        const body = document.getElementById('bodyTableClient');
        
        var count = Object.keys(json).length
        for (var i = 0; i < count ; i++) {

            var hilera = document.createElement("tr");

            var celda1 = document.createElement("td");
            var textoCelda1 = document.createTextNode(json[i].ID_CLIENTE);
            celda1.appendChild(textoCelda1);
            var celda2 = document.createElement("td");
            var textoCelda2 = document.createTextNode(json[i].NOMBRES);
            celda2.appendChild(textoCelda2);
            var celda3 = document.createElement("td");
            var textoCelda3 = document.createTextNode(json[i].APELLIDOS);
            celda3.appendChild(textoCelda3);
            var celda4 = document.createElement("td");
            var textoCelda4 = document.createTextNode(json[i].FECHA_NACIMIENTO);
            celda4.appendChild(textoCelda4);
            var celda5 = document.createElement("td");
            var textoCelda5 = document.createTextNode(json[i].NUMERO_DOCUMENTO);
            celda5.appendChild(textoCelda5);
            var celda6 = document.createElement("td");
            var textoCelda6 = document.createTextNode(json[i].DIRECCION);
            celda6.appendChild(textoCelda6);
            hilera.appendChild(celda1);
            hilera.appendChild(celda2);
            hilera.appendChild(celda3);
            hilera.appendChild(celda4);
            hilera.appendChild(celda5);
            hilera.appendChild(celda6);
            
        
            // agrega la hilera al final de la tabla (al final del elemento tblbody)
            body.appendChild(hilera);
          }
    })
}


document.getElementById('clients').addEventListener("click", 
(evt) => {
    evt.preventDefault();
    mostrarClientes();
})
