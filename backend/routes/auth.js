const express=require('express');
const {
    createUser,
    userLogin,
    changeUserPassword,
}=require('../controllers/auth');
const checkUserAuth=require('../middlewares/auth-middleware');

const router=express.Router();
// Route Level Middleware -to protect
router.use("/changepassword", checkUserAuth);


router.post('/register',createUser);
router.post('/login',userLogin);
router.post("/changePassword", changeUserPassword);

module.exports= router;