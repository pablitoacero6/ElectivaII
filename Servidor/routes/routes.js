const { BADFAMILY } = require('dns');
const {Router} = require('express');
const router = Router();
const DB = require('../config/config');

router.get('/',(req,res)=> {
    res.status(200).json({
        message: "ruta status 200"
    })
});

router.get('/fromOracle', async (req, res)=> {
    const usuarios =[];
    sql ="select * from userbank";
    
    let result = await DB.Open(sql,[],false);
    //console.log(result.rows);
    console.log(usuarios);
    result.rows.map(user => {
        let userSchema ={
            "NAME": user[0],
            "PASSWORD":user[1]
        }
        usuarios.push(userSchema)
    });
    res.json({usuarios});
});

router.get('/register', async (req,res)=> {
    const usuarios =[];
    sql ="select * from client";

    let result = await DB.Open(sql,[],false);
    console.log(result);
    result.rows.map(user => {
        let userSchema ={
            "NAMES": user[0],
            "LASTNAMES":user[1]
        }
        usuarios.push(userSchema)
    });
    res.json({usuarios});
});


module.exports = router;