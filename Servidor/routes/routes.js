
const {Router} = require('express');
const router = Router();
const DB = require('../config/config');

router.get('/',(req,res)=> {
    res.status(200).json({
        message: "ruta status 200"
    })
});

router.post('/createClient', async(req,res) => {

});


router.get('/register', async (req,res)=> {
    const usuarios =[];
    sql ="select * from client";

    let result = await DB.Open(sql,[],false);
    console.log(result);
    result.rows.map(user => {
        let userSchema ={
            "NAMES": user[0],
            "LASTNAMES":user[1],
            "DATEBIRTH":user[2],
            "DOCUMENT":user[3],
            "ADDRESS":user[4]
        }
        usuarios.push(userSchema)
    });
    res.json(usuarios);
});


module.exports = router;