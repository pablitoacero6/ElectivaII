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
});

cerrarPopup3.addEventListener('click', function() {
    overlay3.classList.remove('active');
    popup3.classList.remove('active');
});

/* CONEXION */

var url = "http://localhost:3000";

function verifyConnection(){
    fetch(url + "/register").then(function(res) {
        return res.json();
    }).then(function (json) {
        console.log(json);
    })
}

document.getElementById("saveCreateClient").addEventListener("click", 
(evt) => {
    evt.preventDefault();
    verifyConnection();
})