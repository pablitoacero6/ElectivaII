const oracledb = require('oracledb');

DB = {
    user: 'ADMIN',
    password: '123',
    connectString: 'localhost:1521'
}

oracledb.getConnection(DB, function(err, connection){{
    if(err){
        console.error("db has connected failed: "+ err.message)
        return ;
    }
    console.log("DB has connected")
}});

async function open(sql, binds, autoCommit){
    let con = await oracledb.getConnection(DB);
    let result = await con.execute(sql,binds,{autoCommit});
    con.release();
    return result;
}

exports.Open = open;