const pool=require('../database/connect');
const dotenv= require('dotenv');
dotenv.config()

//setup email send


const verifyOtp=async(req,res)=>{
    try {
      const {otp,orderId}=req.body;
      // const userId=req.user.id;

      if(!otp || !orderId){
        res.status(500).json({
          "status": 500,
          "message": "Empty OTP not allowed"
        
      });
      }else{
//Fetch Otp from database with OrderId
        const query=`SELECT value, createdAt FROM otp WHERE orderId = ?`;
        // const img=skfksalfdjkldsa;
        // false(`d:backe/${img}`)

            pool.query(query, [orderId], (err, result) => {
              if (err) {
                console.error(err);
                 res.status(500).send('Internal Server Error');
                
              } else {
                if (result.length > 0) {
                  const orderOtp = result[0].value;
                  const createdAt=(result[0].createdAt);
                  console.log("createdAtBefore addition============",createdAt)

                  createdAt.setMinutes(createdAt.getMinutes() + 2);
                  console.log("createdAt============",createdAt, Date.now())
                  //check tha expiry of otp code
                  if(createdAt< Date.now()){
                    console.log(":",createdAt===Date.now())
                    res.status(500).json({
                      "status": 500,
                      "message": "OTP has been expired"
                  });
                    
                  }else{
                    if(otp===orderOtp){
                      const updateQuery = 'UPDATE orders SET otpVerified = true WHERE id = ?';
                      pool.query(updateQuery, [orderId],(err,result)=>{
                        if(err){
                         console.log(err)
                        }
                      });
                      res.status(201).json({
                        "status": 201,
                        "message": "Order Created successfully.Order will be placed soon"
                      
                    });
                      
                    }else{
                      res.status(500).json({
                        "status": 500,
                        "message": "OTP didnt match"
                      
                    });

                    }
                  }

                } else {
                  res.status(500).json('Internal Server Error');
                }
              }
            });

     
      }

    

    } catch (error) {
        console.log(error);
        res.json(error);
    }
}




module.exports={
 verifyOtp
}