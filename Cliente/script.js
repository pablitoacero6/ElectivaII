var url = "http://localhost:3000";

function verifyConnection(){
    fetch(url + "/fromOracle").then(function(res) {
        return res.json();
    }).then(function (json) {
        console.log(json);
    })
}

document.getElementById("submit").addEventListener("click", 
(evt) => {
    evt.preventDefault();
    verifyConnection();
})