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

accounts.addEventListener('click', function() {
    overlay3.classList.add('active');
    popup3.classList.add('active');
});

createBeneficiary.addEventListener('click', function() {
    overlay4.classList.add('active');
    popup4.classList.add('active');
});


Beneficiarys.addEventListener('click', function() {
    overlay6.classList.add('active');
    popup6.classList.add('active');
});

cerrarPopup1.addEventListener('click', function() {
    overlay1.classList.remove('active');
    popup1.classList.remove('active');
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


cerrarPopup6.addEventListener('click', function() {
    overlay6.classList.remove('active');
    popup6.classList.remove('active');
});

var url = "http://localhost:4000";
const bodycodAcoount = document.getElementById('codigoCuenta')

var consecutivo = []

    fetch(url + "/verCliente").then(function(res) {
        return res.json();
    }).then(function (json) { 
        var count = Object.keys(json).length
        for (var i = 0; i < count ; i++) {
                    
            fetch(url + "/verCuentas", {
                method: 'POST',
                body: JSON.stringify({
                    ID_CLIEN: json[i].ID_CLIENTE
                }),
                headers: {
                    'Accept': 'application/json',
                    'Content-Type': 'application/json'
                }
            }).then(function(res) {
                return res.json();
            }).then(function (json) {      
                var count = Object.keys(json).length
                for (var j = 0; j < count ; j++) {
                    consecutivo.push(json[j].NO_CUENTA)                    
                  }
            })
            
        }
        
        
    })
    

    



//----------------------------------------------------------------------------
const bodyTableAccounts = document.getElementById('bodyTableAccount');

/* CREAR CUENTA */

/* MOSTRAR CLIENTES EN crear cuenta */

function mostrarClienteCrearCuenta(){
    fetch(url + "/verCliente").then(function(res) {
        return res.json();
    }).then(function (json) {
        const body = document.getElementById('ClientListAccount');
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
    mostrarClienteCrearCuenta();

})


// extraer divisas

var opcionSeleccionadaDivisa = 'COP'
function opcionSeleccionarDivisa() {
    const indice = document.getElementById('divisaList').selectedIndex;
    if(indice === -1) return; // Esto es cuando no hay elementos
    opcionSeleccionadaDivisa = document.getElementById('divisaList').options[indice].text;
  };

document.getElementById('divisaList').addEventListener("change",
(evt) => {
    evt.preventDefault();
    opcionSeleccionarDivisa();
})

// extraer tipo de cuenta



//extraer cliente titular
var titularCuenta = ' '

function opcionSeleccionarTitularCuentaCrear() {
    const indice = document.getElementById('ClientListAccount').selectedIndex;
    if(indice === -1) return; // Esto es cuando no hay elementos
    titularCuenta = (document.getElementById('ClientListAccount').options[indice].text).substr(0,5);
};

document.getElementById('ClientListAccount').addEventListener("change",
(evt) => {
    evt.preventDefault();
    opcionSeleccionarTitularCuentaCrear();
})

//crear cuenta

function crearCuenta(){
    fetch(url + "/crearCuenta", {
        method: 'POST',
        body: JSON.stringify({
            NO_ACCOUNT: document.getElementById('accountCod').value ,
            ID_CLIENT: titularCuenta,
            CURRENCY: opcionSeleccionadaDivisa,
            BALANCE: document.getElementById('balanceAccount').value
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
    if(comprobarDatosCrearCuenta()==0){
        location.reload()
    }else{  
        crearCuenta();
    }
})

function comprobarDatosCrearCuenta(){
    for (let index = 0; index < consecutivo.length; index++) {
        const element = consecutivo[index];
        console.log(element)
        if(element == document.getElementById('accountCod').value){
            confirm("El codigo de la cuenta ya existe")
            return 0
        }
        
    }
}
//---------------------------------------------------------------------------------

/* MOSTRAR CUENTAS */

/* MOSTRAR CLIENTES EN EL SELECTOR DE cuentas */

function mostrarClientesCuentas(){
    fetch(url + "/verCliente").then(function(res) {
        return res.json();
    }).then(function (json) {
        const body = document.getElementById('accountList');
        var count = Object.keys(json).length
        for (let index = 0; index < count; index++) {
            var option = document.createElement("option")
            var textoOption = document.createTextNode(json[index].ID_CLIENTE +" - "+ json[index].NOMBRES);
            option.appendChild(textoOption);
            body.appendChild(option);
        }
    })
}

document.getElementById('accounts').addEventListener("click", 
(evt) => {
    evt.preventDefault();
    mostrarClientesCuentas();
})

/* elegir cliente */

var titularCuentas = ''

function opcionSeleccionarTitularCuenta() {
    const indice = document.getElementById('accountList').selectedIndex;
    if(indice === -1) return; // Esto es cuando no hay elementos
    titularCuentas = (document.getElementById('accountList').options[indice].text).substr(0,5);
  };

document.getElementById('accountList').addEventListener("change",
(evt) => {
    evt.preventDefault();
    opcionSeleccionarTitularCuenta();
    bodyTableAccounts.innerHTML = ''
    mostrarCuentas();
})

// mostrar cuentas

function mostrarCuentas(){
    fetch(url + "/verCuentas", {
        method: 'POST',
        body: JSON.stringify({
            ID_CLIEN: titularCuentas
        }),
        headers: {
            'Accept': 'application/json',
            'Content-Type': 'application/json'
        }
    }).then(function(res) {
        return res.json();
    }).then(function (json) {
        
        
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
            hilera.appendChild(celda1);
            hilera.appendChild(celda2);
            hilera.appendChild(celda3);
            hilera.appendChild(celda4);
            hilera.appendChild(celda5);
            
        
            // agrega la hilera al final de la tabla (al final del elemento tblbody)
            bodyTableAccounts.appendChild(hilera);
          }
    })
}

/* BENEFICIARIOS */

/* CREAR BENEFICIARIOS */

/* MOSTRAR CLIENTES EN EL SELECTOR DE crear beneficiario */

function mostrarClientesBeneficiarios(){
    fetch(url + "/verCliente").then(function(res) {
        return res.json();
    }).then(function (json) {
        const body = document.getElementById('clientListBen');
        var count = Object.keys(json).length
        for (let index = 0; index < count; index++) {
            var option = document.createElement("option")
            var textoOption = document.createTextNode(json[index].ID_CLIENTE +" - "+ json[index].NOMBRES);
            option.appendChild(textoOption);
            body.appendChild(option);
        }
    })
}

document.getElementById('createBeneficiary').addEventListener("click", 
(evt) => {
    evt.preventDefault();
    mostrarClientesBeneficiarios();
})

/* mostrar cuentas de los clientes en crear beneficiario */




/* elegir cliente */

var titularBeneficiario = ''
const bodyAccountListBeneficiary = document.getElementById('accountListBen');

function opcionSeleccionarTitularBeneficiario() {
    const indice = document.getElementById('clientListBen').selectedIndex;
    if(indice === -1) return; // Esto es cuando no hay elementos
    titularBeneficiario = (document.getElementById('clientListBen').options[indice].text).substr(0,5);
  };

document.getElementById('clientListBen').addEventListener("change",
(evt) => {
    evt.preventDefault();
    opcionSeleccionarTitularBeneficiario();
    bodyAccountListBeneficiary.innerHTML = ''
    mostrarCuentasBeneficiario();
})

function mostrarCuentasBeneficiario(){
    fetch(url + "/verCuentas", {
        method: 'POST',
        body: JSON.stringify({
            ID_CLIEN: titularBeneficiario
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
            bodyAccountListBeneficiary.appendChild(option);
        }
    })
}

//extraer cuenta del titular del beneficiario

var cuentaTitular = ''

function opcionSeleccionarCuentaTitular() {
    const indice = document.getElementById('accountListBen').selectedIndex;
    if(indice === -1) return; // Esto es cuando no hay elementos
    cuentaTitular = document.getElementById('accountListBen').options[indice].text;
  };

document.getElementById('accountListBen').addEventListener("change",
(evt) => {
    evt.preventDefault();
    opcionSeleccionarCuentaTitular();
    document.getElementById('clientlistBeneficiarys').innerHTML = ''
    mostrarClientesparaBene();
})


function mostrarClientesparaBene(){
    fetch(url + "/verCliente").then(function(res) {
        return res.json();
    }).then(function (json) {
        const body = document.getElementById('clientlistBeneficiarys');
        var count = Object.keys(json).length
        for (let index = 0; index < count; index++) {
            var option = document.createElement("option")
            var textoOption = document.createTextNode(json[index].ID_CLIENTE +" - "+ json[index].NOMBRES);
            option.appendChild(textoOption);
            body.appendChild(option);
        }
    })
}

var beneficiarioCod = ''
function seleccionarBeneficiarioAAsociar() {
    const indice = document.getElementById('clientlistBeneficiarys').selectedIndex;
    if(indice === -1) return; // Esto es cuando no hay elementos
    beneficiarioCod = (document.getElementById('clientlistBeneficiarys').options[indice].text).substr(0,5);
  };

document.getElementById('clientlistBeneficiarys').addEventListener("change",
(evt) => {
    evt.preventDefault();
    seleccionarBeneficiarioAAsociar();
    document.getElementById('accountlistBeneficiarys').innerHTML = ''
    console.log(beneficiarioCod)
    mostrarCuentasBene();
})

function mostrarCuentasBene(){
    fetch(url + "/verCuentas", {
        method: 'POST',
        body: JSON.stringify({
            ID_CLIEN: beneficiarioCod
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
            document.getElementById('accountlistBeneficiarys').appendChild(option);
        }
    })
}
var cuentaBeneficiarioSelecc = ''
function seleccionarCuentaBe() {
    const indice = document.getElementById('accountlistBeneficiarys').selectedIndex;
    if(indice === -1) return; // Esto es cuando no hay elementos
    cuentaBeneficiarioSelecc = document.getElementById('accountlistBeneficiarys').options[indice].text;
  };

  
var primeraMoneda = ''
var segundaMoneda = ''

document.getElementById('accountlistBeneficiarys').addEventListener("change",
(evt) => {
    evt.preventDefault();
    seleccionarCuentaBe();
    setearDatos();
    sacarMonedaPrimera()
    sacarMonedaSegunda()
})

var seteoNombre = ''
var seteoNoDocumento = ''

function setearDatos(){
    fetch(url + "/verClienteUno", {
        method: 'POST',
        body: JSON.stringify({
            ID_CLIENTE: beneficiarioCod
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
            seteoNombre = json[index].NOMBRES;
            seteoNoDocumento = json[index].NUMERO_DOCUMENTO;
            console.log(seteoNombre + seteoNoDocumento)
        }
    })
}

// crear beneficiario


function sacarMonedaPrimera(){
    fetch(url + "/verCuentasMoneda", {
        method: 'POST',
        body: JSON.stringify({
            ID_CLIEN: titularBeneficiario,
            NO_ACCOUNT: cuentaTitular
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
            console.log("aa" + json[index].DIVISA)
            primeraMoneda = json[index].DIVISA;
        }
    })
}

function sacarMonedaSegunda(){
    fetch(url + "/verCuentasMoneda", {
        method: 'POST',
        body: JSON.stringify({
            ID_CLIEN: beneficiarioCod,
            NO_ACCOUNT: cuentaBeneficiarioSelecc
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
            segundaMoneda = json[index].DIVISA;

        }
    })
}

function crearBeneficiario(){
    fetch(url + "/crearBeneficiario", {
        method: 'POST',
        body: JSON.stringify({
            ID_BENEFICIARY: titularBeneficiario,
            NO_ACCOUNT: cuentaTitular,
            ID_CLIENT: beneficiarioCod,
            NAMES: seteoNombre,
            BEN_ACCOUNT: cuentaBeneficiarioSelecc,
            NO_DOCUMENT: seteoNoDocumento,
            ID_BANK: cuentaTitular.substring(0,3)
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

document.getElementById("saveBeneficiary").addEventListener("click", 
(evt) => {
    evt.preventDefault();
    
    console.log(primeraMoneda + segundaMoneda)
    if(comprobarDatosCrearBeneficiario() == 0){
        location.reload()
    }else{  
        crearBeneficiario();
    }
})

function comprobarDatosCrearBeneficiario(){
    console.log(primeraMoneda + segundaMoneda)
    if(primeraMoneda != segundaMoneda){
        confirm("Las cuentas tienen monedas diferentes")
        return 0;
    }
}

//----------------------------------------------------------------------------------
/* MOSTRAR BENEFICIARIOS */

const bodyTableBeneficiarys = document.getElementById('tableBeneficiarys');

function mostrarCliBeneficiarios(){
    fetch(url + "/verCliente").then(function(res) {
        return res.json();
    }).then(function (json) {
        const body = document.getElementById('ClientsListBen');
        var count = Object.keys(json).length
        for (let index = 0; index < count; index++) {
            var option = document.createElement("option")
            var textoOption = document.createTextNode(json[index].ID_CLIENTE +" - "+ json[index].NOMBRES);
            option.appendChild(textoOption);
            body.appendChild(option);
        }
    })
}

document.getElementById('beneficiarys').addEventListener("click", 
(evt) => {
    evt.preventDefault();
    mostrarCliBeneficiarios();
})

var titularBeneficiarios = ''
const bodyAccountListBeneficiarys = document.getElementById('accountsListBen');

function opcionSeleccionarTitularBeneficiarios() {
    const indice = document.getElementById('ClientsListBen').selectedIndex;
    if(indice === -1) return; // Esto es cuando no hay elementos
    titularBeneficiarios = (document.getElementById('ClientsListBen').options[indice].text).substr(0,5);
  };

document.getElementById('ClientsListBen').addEventListener("change",
(evt) => {
    evt.preventDefault();
    opcionSeleccionarTitularBeneficiarios();
    bodyAccountListBeneficiarys.innerHTML = ''
    mostrarCuentasBeneficiarios();
})

function mostrarCuentasBeneficiarios(){
    fetch(url + "/verCuentas", {
        method: 'POST',
        body: JSON.stringify({
            ID_CLIEN: titularBeneficiarios
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
            bodyAccountListBeneficiarys.appendChild(option);
        }
    })
}

//extraer cuenta del titular del beneficiario

var cuentaTitularBeneficiarios = ''

function opcionSeleccionarCuentaTitularBeneficiarios() {
    const indice = document.getElementById('accountsListBen').selectedIndex;
    if(indice === -1) return; // Esto es cuando no hay elementos
    cuentaTitularBeneficiarios = document.getElementById('accountsListBen').options[indice].text;
  };

document.getElementById('accountsListBen').addEventListener("change",
(evt) => {
    evt.preventDefault();
    opcionSeleccionarCuentaTitularBeneficiarios();
    bodyTableBeneficiarys.innerHTML = ''
    mostrarBeneficiarios();
})

function mostrarBeneficiarios(){
    fetch(url + "/verBeneficiarios", {
        method: 'POST',
        body: JSON.stringify({
            ID_CLIENTE: titularBeneficiarios,
            NO_ACCOUNT: cuentaTitularBeneficiarios
        }),
        headers: {
            'Accept': 'application/json',
            'Content-Type': 'application/json'
        }
    }).then(function(res) {
        return res.json();
    }).then(function (json) {
        
        
        var count = Object.keys(json).length
        for (var i = 0; i < count ; i++) {

            var hilera = document.createElement("tr");

            var celda1 = document.createElement("td");
            var textoCelda1 = document.createTextNode(json[i].ID_BENEFICIARIO);
            celda1.appendChild(textoCelda1);
            var celda2 = document.createElement("td");
            var textoCelda2 = document.createTextNode(json[i].NOMBRE);
            celda2.appendChild(textoCelda2);
            var celda3 = document.createElement("td");
            var textoCelda3 = document.createTextNode(json[i].NUMERO_CUENTA);
            celda3.appendChild(textoCelda3);
            var celda4 = document.createElement("td");
            var textoCelda4 = document.createTextNode(json[i].TIPO_DOCUMENTO);
            celda4.appendChild(textoCelda4);
            var celda5 = document.createElement("td");
            var textoCelda5 = document.createTextNode(json[i].NUMERO_DOCUMENTO);
            celda5.appendChild(textoCelda5);
            var celda6 = document.createElement("td");
            var textoCelda6 = document.createTextNode(json[i].ID_BANCO);
            celda6.appendChild(textoCelda6);
            hilera.appendChild(celda1);
            hilera.appendChild(celda2);
            hilera.appendChild(celda3);
            hilera.appendChild(celda4);
            hilera.appendChild(celda5);
            hilera.appendChild(celda6);
            
        
            // agrega la hilera al final de la tabla (al final del elemento tblbody)
            bodyTableBeneficiarys.appendChild(hilera);
          }
    })
}