const mysql= require('mysql2');
const dotenv= require('dotenv');
dotenv.config()

//db connection

const pool=  mysql.createPool({
        connectionLimit:10,
        host:"localhost",
        user:"root",
        password:"admin",
        database:"ecommerce",

})

module.exports=pool;