
const mysql = require("mysql");
const db = mysql.createConnection({

        host:"localhost",            
        user: "root",              //chatdb                  //root
        password:'',                //chatdb*774088783#       //''
        database: "chatapp",         // chatapp    
        port: 3306,
        charset: "utf8mb4",
        dateStrings: true,
});

module.exports = db;