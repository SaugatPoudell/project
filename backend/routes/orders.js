const express=require('express');
const checkUserAuth=require('../middlewares/auth-middleware');
const router=express.Router();

const {
    createOrder,
}= require('../controllers/orders');

const {verifyOtp}=require('../controllers/otp');

router.use("/createOrder", checkUserAuth);
router.use("/verifyOtp", verifyOtp);


router.post('/createOrder',createOrder)
router.post('/verifyOtp',verifyOtp);

module.exports= router;
