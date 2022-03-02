const express = require('express');
const morgan = require('morgan');
const cors = require('cors');
const app = express();

app.use(cors());


const router = require('../routes/routes.js');

/* Configuracion */

app.set('port', 3000);

app.use(morgan('dev'));
app.use(express.json());
app.use(express.urlencoded({extended:false}));
app.use(router);

app.listen(app.get('port'),()=> {
    console.log("server status 200 on port 3000");
});