var createAccount = document.getElementById("createAccount"),
    editAccount = document.getElementById("editAccount"),
    accounts = document.getElementById("accounts"),
    createBeneficiary = document.getElementById("createBeneficiary"),
    editBeneficiary = document.getElementById("editBeneficiary"),
    Beneficiarys = document.getElementById("beneficiarys"),
    overlay1 = document.getElementById("overlay1"),
    overlay2 = document.getElementById("overlay2"),
    overlay3 = document.getElementById("overlay3"),
    overlay4 = document.getElementById("overlay4"),
    overlay5 = document.getElementById("overlay5"),
    overlay6 = document.getElementById("overlay6"),
    popup1 = document.getElementById("popup1"),
    popup2 = document.getElementById("popup2"),
    popup3 = document.getElementById("popup3"),
    popup4 = document.getElementById("popup4"),
    popup5 = document.getElementById("popup5"),
    popup6 = document.getElementById("popup6"),
    cerrarPopup1 = document.getElementById("cerrarPopup1"),
    cerrarPopup2 = document.getElementById("cerrarPopup2"),
    cerrarPopup3 = document.getElementById("cerrarPopup3"),
    cerrarPopup4 = document.getElementById("cerrarPopup4"),
    cerrarPopup5 = document.getElementById("cerrarPopup5"),
    cerrarPopup6 = document.getElementById("cerrarPopup6");

createAccount.addEventListener('click', function() {
    overlay1.classList.add('active');
    popup1.classList.add('active');
});

editAccount.addEventListener('click', function(){
    overlay2.classList.add('active');
    popup2.classList.add('active');
});

accounts.addEventListener('click', function() {
    overlay3.classList.add('active');
    popup3.classList.add('active');
});

createBeneficiary.addEventListener('click', function() {
    overlay4.classList.add('active');
    popup4.classList.add('active');
});

editBeneficiary.addEventListener('click', function(){
    overlay5.classList.add('active');
    popup5.classList.add('active');
});

Beneficiarys.addEventListener('click', function() {
    overlay6.classList.add('active');
    popup6.classList.add('active');
});

cerrarPopup1.addEventListener('click', function() {
    overlay1.classList.remove('active');
    popup1.classList.remove('active');
});

cerrarPopup2.addEventListener('click', function() {
    overlay2.classList.remove('active');
    popup2.classList.remove('active');
});

cerrarPopup3.addEventListener('click', function() {
    overlay3.classList.remove('active');
    popup3.classList.remove('active');
    location.reload()
});

cerrarPopup4.addEventListener('click', function() {
    overlay4.classList.remove('active');
    popup4.classList.remove('active');
});

cerrarPopup5.addEventListener('click', function() {
    overlay5.classList.remove('active');
    popup5.classList.remove('active');
});

cerrarPopup6.addEventListener('click', function() {
    overlay6.classList.remove('active');
    popup6.classList.remove('active');
});

var url = "http://localhost:3000";

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

document.getElementById('createAccount').addEventListener("click", 
(evt) => {
    evt.preventDefault();
    mostrarEditarClientes();
})

/* CREAR CUENTA */

// extraer divisas
var opcionSeleccionadaDivisa = 'COP'
function opcionSeleccionarDivisa() {
    const indice = document.getElementById('divisaList').selectedIndex;
    if(indice === -1) return; // Esto es cuando no hay elementos
    const opcionSeleccionadaDivisa = document.getElementById('divisaList').options[indice].text;
  };

document.getElementById('divisaList').addEventListener("change",
(evt) => {
    evt.preventDefault();
    opcionSeleccionarDivisa();
})

// extraer tipo de cuenta
var opcionSeleccionadoTipoCuenta = 'NOR'

function opcionSeleccionarTipoCuenta() {
    const indice = document.getElementById('typeAccount').selectedIndex;
    if(indice === -1) return; // Esto es cuando no hay elementos
    const opcionSeleccionadoTipoCuenta = document.getElementById('typeAccount').options[indice].text;
  };

document.getElementById('typeAccount').addEventListener("change",
(evt) => {
    evt.preventDefault();
    opcionSeleccionarTipoCuenta();
})


function crearCuenta(){
    fetch(url + "/crearCuenta", {
        method: 'POST',
        body: JSON.stringify({
            NO_ACCOUNT: document.getElementById('accountCod').value ,
            CURRENCY: opcionSeleccionadaDivisa,
            BALANCE: document.getElementById('balanceAccount').value,
            OVERSHOOT_VALUE: document.getElementById('balanceAccount').value * 0.25,
            ACCOUNT_TYPE: opcionSeleccionadoTipoCuenta,
            BENEFICIARY_LIST: null
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

document.getElementById("saveCreateAccount").addEventListener("click", 
(evt) => {
    evt.preventDefault();
    crearCuenta();
})

/* MOSTRAR CUENTAS */

/* MOSTRAR CLIENTE */

function mostrarCuentas(){
    fetch(url + "/verCuentas").then(function(res) {
        return res.json();
    }).then(function (json) {
        const body = document.getElementById('bodyTableAccount');
        
        var count = Object.keys(json).length
        for (var i = 0; i < count ; i++) {

            var hilera = document.createElement("tr");

            var celda1 = document.createElement("td");
            var textoCelda1 = document.createTextNode(json[i].NO_CUENTA);
            celda1.appendChild(textoCelda1);
            var celda2 = document.createElement("td");
            var textoCelda2 = document.createTextNode(json[i].DIVISA);
            celda2.appendChild(textoCelda2);
            var celda3 = document.createElement("td");
            var textoCelda3 = document.createTextNode(json[i].SALDO);
            celda3.appendChild(textoCelda3);
            var celda4 = document.createElement("td");
            var textoCelda4 = document.createTextNode(json[i].SOBREGIRO_SALDO);
            celda4.appendChild(textoCelda4);
            var celda5 = document.createElement("td");
            var textoCelda5 = document.createTextNode(json[i].FECHA_CREACION);
            celda5.appendChild(textoCelda5);
            var celda6 = document.createElement("td");
            var textoCelda6 = document.createTextNode(json[i].TIPO_CUENTA);
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


document.getElementById('accounts').addEventListener("click", 
(evt) => {
    evt.preventDefault();
    mostrarCuentas();
})
