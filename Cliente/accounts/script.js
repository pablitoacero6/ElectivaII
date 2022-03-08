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