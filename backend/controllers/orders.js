const pool=require('../database/connect');
const dotenv= require('dotenv');
dotenv.config()
const nodemailer = require("nodemailer");
//setup email send
const transporter = nodemailer.createTransport({
    host: "smtp.gmail.com",
    port: 465,
    secure: true,
    auth: {
      user: process.env.EMAIL_USER,
      pass: process.env.EMAIL_PASSWORD,
    },
  });
  const otp= Math.floor(Math.random()*90000+10000);
  const createOrder=async(req,res)=>{
    const {productIds,total,}= req.body;
   console.log("productIds",productIds)
    const productIdCombine=`"${productIds}"`;
    console.log(req.body);
    const userId= req.user.id;
    const email=  req.user.email;
    console.log(email);
    let  orderId;
    const query = 'INSERT INTO orders (userId, total,productIds,otp) VALUES (?, ?, ?,? )';


    pool.query(query, [userId, total, productIdCombine,otp], (err, results) => {
        if (err) {
          console.error(err);
          res.status(500).send('Internal Server Error');
        } else {
          orderId= results.insertId;  
          //do it here................
          const otpQuery = 'INSERT INTO otp (productId, value, orderId,userId) VALUES (?, ?, ?,?)';

          pool.query(otpQuery, [Number(productIds[0]), otp, orderId,userId], (otpErr) => {
              if (otpErr) {
                console.error(otpErr);
                res.status(500).send('Internal Server Error');
              } else {
                try {
                 sendOTPEmail(email);
              
                res.status(201).json({
                  "status": 201,
                  "message": "Order Created successfully, Please verify OTP",
                  "otp":otp,
                  "orderId":orderId
                
              });

                } catch (error) {
                  console.error(otpErr);
                  res.status(500).json({
                    "status": 500,
                    "message": "Failed to create order",
                                     
                });
                }
               
                 
              }
            });
        }
      });

      
        const sendOTPEmail= async(email)=>{
  
            //email info and send
            const mailInfo = {
                from: process.env.EMAIL_USER, // sender address
                to: email, // list of receivers
                subject: "OTP for your product", // Subject line
                html: `<p>Kindly Use this <b> ${otp} </b> OTP to verify order</p>`, // plain text body
    
            };
          await  transporter.sendMail(mailInfo);
        }
      

}


module.exports={
    createOrder,
}