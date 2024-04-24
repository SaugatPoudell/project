const bcrypt = require('bcrypt');
var jwt = require('jsonwebtoken');
const pool=require('../database/connect');
const dotenv = require("dotenv");

dotenv.config();

//create user
const createUser= async(req,res)=>{

        try {
            console.log("req.body======",req.body);
          const { name, email, password, password_confirm,address } = req.body;
          const result = await pool
            .promise()
            .query(`SELECT * FROM users WHERE email = ?`, [email]);
          const user = result[0];
          if (user.length > 0) {

            return res
              .status(400)
              .json({ status: "failed", message: "Email already exists" });
          }
          if (!name || !email || !password || !password_confirm || !address) {
            return res
              .status(400)
              .json({ status: "failed", message: "All fields are required" });
          }
          if (password !== password_confirm) {
            return res
              .status(400)
              .json({ status: "failed", message: "Passwords do not match" });
          }
    
          const salt = await bcrypt.genSalt(10);
          const hashPassword = await bcrypt.hash(password, salt);
          const insertResult = await pool
            .promise()
            .query("INSERT INTO users SET ?", {
              name: name,
              email: email,
              password: hashPassword,
              address,
            });
          const saved_user_id = insertResult[0].id;
          // generate JWT token
          const secret = process.env.JWT_SECRET_KEY;
          const token = jwt.sign({ userID: saved_user_id }, secret, {
            expiresIn: "5d",
          });
          res.json({
            status: "success",
            message: "Registration success",
            token: token,
          });
        } catch (error) {
          console.log(error);
          res
            .status(500)
            .json({ status: "failed", message: "Internal server error" });
        };
      
};

//login user
const userLogin = async (req, res) => {
    try {
      const { email, password } = req.body;
      if (email && password) {
        const [rows, fields] = await pool
          .promise()
          .query("SELECT * FROM users WHERE email = ?", [email]);
        const user = rows[0];
        if (user !== null) {
          const isMatch = await bcrypt.compare(password, user.password);
          if (user.email === email && isMatch) {
            //generate JWT token
            const secret = process.env.JWT_SECRET_KEY;
            const token = jwt.sign({ userID: user.id }, secret, {
              expiresIn: "5d",
            });
            res.send({
              status: "success",
              message: "Login successfully",
              token: token,
              user: user,
            });
          } else {
            res.send({
              status: "failed",
              message: isMatch ? "Email is incorrect" : "Password is incorrect",
            });
          }
        } else {
          res.send({
            status: "failed",
            message: "Your are not a Registered User",
          });
        }
      } else {
        res.send({ status: "failed", message: "All fields are required" });
      }
    } catch (error) {
      console.log(error);
      res.send({ status: "failed", message: "Invalid Credentials" });
    }
  };

//change user password

const changeUserPassword = async (req, res) => {
    const { password, password_confirm } = req.body;
    if (password && password_confirm) {
      if (password !== password_confirm) {
        res.send({
          status: "failed",
          message: "Password and Password-confirm doesnot match",
        });
      } else {
        const salt = await bcrypt.genSalt(10);
        const newHashPassword = await bcrypt.hash(password, salt);
        await pool
          .promise()
          .query("UPDATE users SET password = ? WHERE id = ?", [
            newHashPassword,
            req.body.id,
          ]);
        console.log(req.users);
        res.send({
          status: "success",
          message: "Password Changed Succesfully",
        });
      }
    } else {
      res.send({ status: "failed", message: "All fields are required" });
    }
  };


module.exports={
    createUser,
    userLogin,
    changeUserPassword,
};