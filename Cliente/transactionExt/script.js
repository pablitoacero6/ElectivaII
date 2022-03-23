/* MOSTRAR CLIENTES */

var url = "http://localhost:4000";
const bodyAcoount = document.getElementById('listaCuentasTitular')
const bodyBeneficiary = document.getElementById('beneficiariosLista')

fetch(url + "/verCliente").then(function(res) {
    return res.json();
}).then(function (json) {
    const body = document.getElementById('listaTitular');
    var count = Object.keys(json).length
    for (let index = 0; index < count; index++) {
        var option = document.createElement("option")
        var textoOption = document.createTextNode(json[index].ID_CLIENTE +" - "+ json[index].NOMBRES);
        option.appendChild(textoOption);
        body.appendChild(option);
    }
})

/* CLIENTE SELECCIONADO */
var titularSeleccionado = ''
function clienteSeleccionado() {
    const indice = document.getElementById('listaTitular').selectedIndex;
    if(indice === -1) return; // Esto es cuando no hay elementos
    titularSeleccionado = (document.getElementById('listaTitular').options[indice].text).substr(0,5);
  };

document.getElementById('listaTitular').addEventListener("change",
(evt) => {
    evt.preventDefault();
    clienteSeleccionado();
    bodyAcoount.innerHTML = ''
    mostrarCuentas();
})

/* CAMBIAR CUENTAS A USAR */

function mostrarCuentas(){
    fetch(url + "/verCuentas", {
        method: 'POST',
        body: JSON.stringify({
            ID_CLIEN: titularSeleccionado
        }),
        headers: {
            'Accept': 'application/json',
            'Content-Type': 'application/json'
        }
    }).then(function(res) {
        return res.json();
    }).then(function (json) {
        var count = Object.keys(json).length
        for (let index = 0; index < count; index++) {
            var option = document.createElement("option")
            var textoOption = document.createTextNode(json[index].NO_CUENTA);
            option.appendChild(textoOption);
            bodyAcoount.appendChild(option);
        }
    })
}

var cuentaTSeleccionada = ''

function cuentaSeleccionada() {
    const indice = document.getElementById('listaCuentasTitular').selectedIndex;
    if(indice === -1) return; // Esto es cuando no hay elementos
    cuentaTSeleccionada = document.getElementById('listaCuentasTitular').options[indice].text;
  };

document.getElementById('listaCuentasTitular').addEventListener("change",
(evt) => {
    evt.preventDefault();
    cuentaSeleccionada();
    pintarCuentaMoneda();
    mostrarBeneficiarios();
})

/*PINTAR MONEDA CLIENTE ELEGIDO */

function pintarCuentaMoneda(){
    fetch(url + "/verCuentasMoneda", {
        method: 'POST',
        body: JSON.stringify({
            ID_CLIEN: titularSeleccionado,
            NO_ACCOUNT: cuentaTSeleccionada
        }),
        headers: {
            'Accept': 'application/json',
            'Content-Type': 'application/json'
        }
    }).then(function(res) {
        return res.json();
    }).then(function (json) {
        var count = Object.keys(json).length
        for (let index = 0; index < count; index++) {
            document.getElementById('monedaCuentaTitular').setAttribute("placeholder",json[index].DIVISA);
        }
    })
}

/* PINTAR BENEFICIARIOS */

function mostrarBeneficiarios(){
    fetch(url + "/verBeneficiarios", {
        method: 'POST',
        body: JSON.stringify({
            ID_CLIENTE: titularSeleccionado,
            NO_ACCOUNT: cuentaTSeleccionada
        }),
        headers: {
            'Accept': 'application/json',
            'Content-Type': 'application/json'
        }
    }).then(function(res) {
        return res.json();
    }).then(function (json) {   
        var count = Object.keys(json).length
        for (let index = 0; index < count; index++) {
            var option = document.createElement("option")
            var textoOption = document.createTextNode(json[index].ID_BENEFICIARIO);
            option.appendChild(textoOption);
            bodyBeneficiary.appendChild(option);
        }           
    })
}

var codBenSelec = ''
var accBen = ''

function beneficiarioSeleccionado() {
    const indice = document.getElementById('beneficiariosLista').selectedIndex;
    if(indice === -1) return; // Esto es cuando no hay elementos
    codBenSelec = document.getElementById('beneficiariosLista').options[indice].text;
  };

document.getElementById('beneficiariosLista').addEventListener("change",
(evt) => {
    evt.preventDefault();
    beneficiarioSeleccionado();    
    document.getElementById('codCuentaBeneficiario').innerHTML = ''
    mostrarsetersBe();  
    
})

function mostrarsetersBe(){
    fetch(url + "/verBeneficiariosCodMon", {
        method: 'POST',
        body: JSON.stringify({
            ID_CLIENTE: titularSeleccionado,
            NO_ACCOUNT: cuentaTSeleccionada,
            ID_BENEFICIARIO:codBenSelec
        }),
        headers: {
            'Accept': 'application/json',
            'Content-Type': 'application/json'
        }
    }).then(function(res) {
        return res.json();
    }).then(function (json) {   
        var count = Object.keys(json).length
        for (let index = 0; index < count; index++) {
            document.getElementById('codCuentaBeneficiario').setAttribute("placeholder",json[index].NUMERO_CUENTA);
            accBen = json[index].NUMERO_CUENTA;
            document.getElementById('monedaBeneficiario').innerHTML = ''
            pintarCuentaMonBene();
        }           
    })
}

function pintarCuentaMonBene(){
    console.log(codBenSelec + accBen)
    fetch(url + "/verCuentasMoneda", {
        method: 'POST',
        body: JSON.stringify({
            ID_CLIEN: codBenSelec,
            NO_ACCOUNT: accBen
        }),
        headers: {
            'Accept': 'application/json',
            'Content-Type': 'application/json'
        }
    }).then(function(res) {
        return res.json();
    }).then(function (json) {
        var count = Object.keys(json).length
        for (let index = 0; index < count; index++) {
            console.log('Hola' + json[index].DIVISA)
            document.getElementById('monedaBeneficiario').setAttribute("placeholder",json[index].DIVISA);
        }
    })
}

/* HACER TRANSACCION */

function crearCuenta(){
    fetch(url + "/transaccionInterna", {
        method: 'POST',
        body: JSON.stringify({
            ID_TRANSACCION: document.getElementById('idTransaccion').value,
            ID_CLIENTE: titularSeleccionado,
            NO_CUENTACLIENTE: cuentaTSeleccionada,
            ID_BENEFICIARIO: codBenSelec,
            NO_CUENTABENEFICIARIO: accBen,
            VALOR: document.getElementById('transfer').value,
            MONEDA: document.getElementById('monedaBeneficiario').getAttribute('placeholder')
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

document.getElementById('sendTransfer').addEventListener("click",
(evt) => {
    crearCuenta();
})

