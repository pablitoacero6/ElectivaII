const oracledb = require('oracledb');

DB = {
    user: 'CONEXION',
    password: '123',
    connectString: 'localhost:1521'
}

async function open(sql, binds, autoCommit){
    let con = await oracledb.getConnection(DB);
    let result = await con.execute(sql,binds,{autoCommit});
    con.release();
    return result;
}

exports.Open = open;