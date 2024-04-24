const jwt =require("jsonwebtoken");
const pool= require('../database/connect');


let checkUserAuth = async(req,res,next)=>{
    let token
    const {authorization}= req.headers
    console.log(req.headers)
    if(authorization && authorization.startsWith('Bearer')){
        try {
            token= authorization.split(' ')[1] 
            console.log(token)
            // verify token 
            const {userID}= jwt.verify(token, process.env.JWT_SECRET_KEY)
            console.log(userID)
            //GET USER FROM TOKEN
            const [rows, fields] = await pool.promise().query('SELECT * FROM users WHERE id = ?', [userID]);
            const user = rows[0];
            req.user=user
            next()
        } catch (error) {
            res.status(401).send({"status":"failed", "message":"unauthorized User"})
        }
    }
    if(!token){
        res.status(403).send({"status":"failed", "message":"unauthorized User, No Token"})
    } 
}
module.exports= checkUserAuth  