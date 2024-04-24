const express=require('express');
const checkUserAuth=require('../middlewares/auth-middleware');
const multer = require('multer');
const path = require('path');
const {
    createProduct,
    getAllProducts,
    getSingleProduct,
    deleteProduct,
    updateProduct
}= require('../controllers/product');

const router=express.Router();
//file upload
// Multer configuration for image upload
const storage = multer.diskStorage({
    destination: function (req, file, cb) {
      cb(null, 'C:/Users/Nitro/Desktop/Test/firstapp/assets');
    },
    filename: function (req, file, cb) {
      const product_image = file.originalname; 
      cb(null,  product_image);
    },
  });
  const imageFilter = function (req, file, cb) {
    // Check if the file is an image
    if (!file.mimetype.startsWith('image/')) {
      return cb(new Error('Only image files are allowed!'), false);
    }
    cb(null, true);
  };
  const upload = multer({storage: storage, fileFilter: imageFilter});

//create product if user is logged in
router.use("/createProduct", checkUserAuth);
router.post('/createProduct',upload.single('image'),createProduct)
router.get('/getAllProducts',getAllProducts);
router.get('/getSingleProduct/:id',getSingleProduct);
router.put('/deleteProduct/:id',deleteProduct);
router.put('/updateProduct/:id',updateProduct);


module.exports= router;