const {Router, response} = require('express');
const router = Router();
const DB = require('../config/config');
const initJson = require('../movements.json')

router.get('/',(req,res)=> {
    res.status(200).json({
        message: "ruta status 200"
    })
});

router.get('/init',(req,res)=> {
    const moves = initJson
    console.log(moves)
    res.json(moves)
});

router.post('/crearCliente', async(req,res) => {
    const client = req.body
    console.log(client)
    sql = "insert into cliente_tab values(" 
    + "'" + client.ID_CLIENTE + "'" + ","
    + "'" + client.NOMBRES + "'" + ","
    + "'" + client.APELLIDOS + "'" + ","
    + "TO_DATE( "+ "'" + client.FECHA_NACIMIENTO + "' , 'dd/mm/yy')" + ","
    + "'" + client.TIPO_DOCUMENTO + "'" + ","
    + "'" + client.NUMERO_DOCUMENTO + "'" + ","
    + "'" + client.DIRECCION + "'" + ","
    + "'" + client.ESTADO_CLIENTE + "'" + ","
    + client.LISTA_CUENTAS
    + ")"

    let result = await DB.Open(sql,[],true);
    console.log(result); 

    res.end('202')
});

//insert into cuenta_tab values ('001-000001', 'COP', 15000000, 3750000, sysdate, 'NOR', null)

router.post('/crearCuenta', async(req,res) => {
    const account = req.body
    console.log(account)
    sql = "insert into cuenta_tab values(" 
    + "'" + account.ID_CLIENTE + "'" + ","
    + "'" + account.NOMBRES + "'" + ","
    + "'" + account.APELLIDOS + "'" + ","
    + "TO_DATE( "+ "'" + account.FECHA_NACIMIENTO + "' , 'dd/mm/yy')" + ","
    + "'" + account.TIPO_DOCUMENTO + "'" + ","
    + "'" + account.NUMERO_DOCUMENTO + "'" + ","
    + "'" + account.DIRECCION + "'" + ","
    + "'" + account.ESTADO_CLIENTE + "'" + ","
    + account.LISTA_CUENTAS
    + ")"

    let result = await DB.Open(sql,[],true);
    console.log(result); 

    res.end('202')
});

router.post('/editarCliente', async(req,res) => {
    const client = req.body
    console.log(client)
    sql = "update cliente_tab set NOMBRES='"+
    client.NOMBRES+"', apellidos='"+client.APELLIDOS+
    "', fecha_nacimiento=TO_DATE('"+client.FECHA_NACIMIENTO+
    "','dd/mm/yy'),numero_documento='"+client.NUMERO_DOCUMENTO+
    "',direccion='"+client.DIRECCION+"' where id_cliente='"+client.ID_CLIENTE+"'" 

    console.log(sql)
    let result = await DB.Open(sql,[],true);
    console.log(result); 

    res.end('202')
});

router.get('/banco', async (req,res)=> {
    sql ="select * from banco_tab";

    let result = await DB.Open(sql,[],false);
    console.log(result);    
});

router.get('/beneficiario', async (req,res)=> {
    sql ="select * from beneficiario_tab";

    let result = await DB.Open(sql,[],false);
    console.log(result);    
});

router.get('/verCliente', async (req,res)=> {
    const usuarios =[];
    sql ="select * from cliente_tab";

    let result = await DB.Open(sql,[],false);
    console.log(result);    
    result.rows.map(user => {
        let userSchema ={
            "ID_CLIENTE": user[0],
            "NOMBRES":user[1],
            "APELLIDOS": user[2],
            "FECHA_NACIMIENTO":user[3],
            "TIPO_DOCUMENTO": user[4],
            "NUMERO_DOCUMENTO":user[5],
            "DIRECCION": user[6],
            "ESTADO_CLIENTE":user[7],
            "LISTA_CUENTAS": user[8]
        }
        usuarios.push(userSchema)
    });
   res.json(usuarios);
});


module.exports = router;