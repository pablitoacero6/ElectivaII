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
    //const usuarios =[];
    sql ="select * from userbank";
    
    let result = await DB.Open(sql,[],false);
    console.log(result);
    //console.log(usuarios);
    /*result.rows.map(user => {
        let userSchema ={
            "NAME": user[0],
            "PASSWORD":user[1]
        }
        userSchema.push(userSchema)
    });*/
    //res.json({users});
});


module.exports = router;