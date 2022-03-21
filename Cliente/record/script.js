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
