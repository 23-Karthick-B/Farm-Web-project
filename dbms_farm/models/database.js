import mysql2 from 'mysql2';

function initSqlConnection() {

    const con = mysql2.createConnection({
        host: "localhost",
        user: "root",
        password: "root123",
        database: "final_database12"
    }).promise();
    con.connect((err) => {
        console.log('database connected sucessfullt')
        if (err) throw err;
    })
    return con
}

export default initSqlConnection

