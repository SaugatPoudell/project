const express=require('express');
const cors=require('cors');
const bodyParser= require('body-parser');
require('dotenv').config();
const pool=require('./database/connect');
const morgan = require('morgan');

//import routes
const authRoutes=require('./routes/auth');
const productRoutes=require('./routes/product');
const ordersRoutes=require('./routes/orders');



//app
const app=express();

function connectToDatabase() {
    return new Promise((resolve, reject) => {
      pool.getConnection((err, connection) => {
        if (err) {
          reject(err);
        } else {
          resolve(connection);
        }
      });
    });
  }
  connectToDatabase()
  .then((connection) => {
    console.log(`db connected ` + connection.threadId);
    // Perform further actions with the connected database
  })
  .catch((err) => {
    console.error(err);
  });


//middlewares
app.use(morgan("dev"));
app.use(bodyParser.json());
app.use(cors());

//routes middleware
app.use('/api',authRoutes);
app.use('/api',productRoutes);
app.use('/api',ordersRoutes);


//port
const port =  8080;

app.listen(port,()=>{
    console.log(`Server is running on ${port}`);
})

