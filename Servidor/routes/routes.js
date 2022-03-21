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

    sql= "DECLARE new_cliente cliente; BEGIN new_cliente := cliente(" 
    + "'" + client.ID_CLIENTE + "'" + ","
    + "'" + client.NOMBRES + "'" + ","
    + "'" + client.APELLIDOS + "'" + ","
    + "TO_DATE( "+ "'" + client.FECHA_NACIMIENTO + "' , 'dd/mm/yy')" + ","
    + "'" + client.TIPO_DOCUMENTO + "'" + ","
    + "'" + client.NUMERO_DOCUMENTO + "'" + ","
    + "'" + client.DIRECCION + "'" + ","
    + "'" + client.ESTADO_CLIENTE+ "');"+
    "INSERT INTO cliente_tab VALUES new_cliente; END;"

    let result = await DB.Open(sql,[],true);
    console.log(result); 

    res.end('202')
});

//insert into cuenta_tab values ('001-000001', 'COP', 15000000, 3750000, sysdate, 'NOR', null)

router.post('/crearCuenta', async(req,res) => {
    const account = req.body
    console.log(account)

    sql= "Begin add_cuenta("
    + "'" + account.NO_ACCOUNT + "'" + ","
    + "'" + account.ID_CLIENT + "'" + ","
    + "'" + account.CURRENCY + "'" + ","
    + account.BALANCE + "," 
    + "'" + account.ACCOUNT_TYPE 
    + "'); End;"

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

router.get('/prueba', async (req,res)=> {
    sql ="begin get_cuentas('00005'); end;";

    let result = await DB.Open(sql,[],false);
    console.log(result);    
});



router.get('/beneficiario', async (req,res)=> {
    sql ="select * from beneficiario_tab";

    let result = await DB.Open(sql,[],false);
    console.log(result);    
});

router.get('/mensaje', async (req,res)=> {
    sql ="select * from mensaje_tab";

    let result = await DB.Open(sql,[],false);
    console.log(result);    
});




router.get('/verCliente', async (req,res)=> {
    const usuarios =[];
    sql ="select id_cliente,nombres,apellidos,fecha_nacimiento,"+
    "tipo_documento,numero_documento,direccion,estado_cliente from cliente_tab";

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
            "ESTADO_CLIENTE":user[7]
        }
        usuarios.push(userSchema)
    });
   res.json(usuarios);
});



router.post('/verCuentas', async (req,res)=> {
    const client = req.body
    const cuentas =[];
    sql="SELECT Emp.NUMERO_CUENTA, Emp.DIVISA, Emp.SALDO, Emp.VALOR_SOBREGIRO, Emp.FECHA_CREACION, Emp.TIPO_CUENTA" +
    " FROM cliente_tab E, TABLE(E.lista_cuentas) Emp" +
    " where E.id_cliente ='" + client.ID_CLIEN + "'"

    let result = await DB.Open(sql,[],false);
    console.log(result);    
    result.rows.map(account => {
        let userSchema ={
            "NO_CUENTA": account[0],
            "DIVISA":account[1],
            "SALDO": account[2],
            "SOBREGIRO_SALDO":account[3],
            "FECHA_CREACION": account[4],
            "TIPO_CUENTA":account[5]
        }
        cuentas.push(userSchema)
    });
   res.json(cuentas);
});


module.exports = router;