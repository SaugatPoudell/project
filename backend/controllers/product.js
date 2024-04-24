const pool=require('../database/connect');

const fi = require('frequent-itemset');
const fs = require('fs');
const csvParser = require('csv-parser');

const createProduct=async(req,res)=>{
    const { category_id, name, description, price } = req.body;
    const product_image = await req.file.originalname; 
  
    const query = 'INSERT INTO product (category_id, name, description, product_image, price) VALUES (?, ?, ?, ?, ?)';
    pool.query(query, [category_id, name, description, product_image, price], (err, results) => {
      if (err) {
        console.error(err);
        res.status(500).send('Internal Server Error');
      } else {
        res.status(201).send('Product added successfully');
      }
    });
}

const getAllProducts=async(req,res)=>{
  let query = 'SELECT * FROM product WHERE isDeleted = false';
  const { category_id, name } = req.query;
  const values=[]
  //check for category or name
  if (category_id) {
    query += ' AND category_id = ?';
    values.push(category_id);
  }
  

  if (name) {
    query += ' AND name LIKE ?';
    values.push(`%${name}%`);
  }

  // Add pagination logic
  const page= Number(req.query.page) || 1
  const  limit = Number(req.query.limit) || 10; 
  const   offset = (Number(page) - 1) * limit || 0; 
  query += ` LIMIT ? OFFSET ?`;
  values.push(limit, offset);

  pool.query(query,values, (err, results) => {
    if (err) {
      console.error(err);
      res.status(500).send('Internal Server Error');
    } else if (results.length===0 ){
      res.json("No Result found")
    
    }else{
      res.json(results);
    }
  });
}


const getSingleProduct=(req,res)=>{
    const id = req.params.id;

    function readCSV(filePath) {
      return new Promise((resolve, reject) => {
          const data = [];
          fs.createReadStream(filePath)
              .pipe(csvParser())
              .on('data', (row) => {
                  // Assuming the data in the CSV file is in the format {'4', '5', '3'}
                  const rowData = Object.values(row)[0]; // Extracting the value from the row object
                  const rowArray = rowData.slice(1, -1).split(',').map(item => item.trim()); // Splitting and trimming the values
                  data.push(rowArray);
              })
              .on('end', () => {
                  resolve(data);
              })
              .on('error', (error) => {
                  reject(error);
              });
      });
  }
  async function findFrequentItemsetsContainingProductId(csvFilePath, productId, minSupport) {
    try {
        // Read CSV file
        const data = await readCSV(csvFilePath);
        // Convert data to format expected by frequent-itemset library
        const rowsWithProductId4 = data.filter(row => row.includes(productId));
        const frequentItemsets = fi(rowsWithProductId4, minSupport, false);
        return frequentItemsets;
    } catch (error) {
        console.error('Error:', error);
        return [];
    }
  }
  const csvFilePath="./apriori.csv"
const minSupport = 0.7;

    const query = 'SELECT * FROM product WHERE id =?  and isDeleted=false';
    pool.query(query, [id], (err, results) => {
    if (err) {
      console.error(err);
      res.status(500).send('Internal Server Error');
    } else {
      if (results.length > 0) {
        findFrequentItemsetsContainingProductId(csvFilePath, id, minSupport)
        .then(frequentItemsets => {
          const recommendIds = frequentItemsets.flatMap(itemset => itemset);
          const items = recommendIds.filter(itemset => !itemset.includes(id));
          if(items.length>=1){
            const recommendedQuery = `SELECT * FROM product WHERE id IN(${items}) and isDeleted=false`;
            pool.query(recommendedQuery, (err, recommendresults) => {
              if (err) {
                console.error(err);
                res.status(500).send('Internal Server Error');
              } else {
                res.json({
                  productById: results[0],
                  recommendItems: recommendresults
              })   
              }
            });
          }else{
            res.json({
              productById: results[0],
              recommendItems: ""
          })   
          }
      
        })
           
      } else {
        res.status(404).send('Product not found');
      }
    }
  });
}
const updateProduct=(req,res)=>{
    res.send("hello need to work")
//     const id = req.params.id;
//   const { category_id, name, description, price } = req.body;

//   const query = 'UPDATE product SET category_id = ?, name = ?, description = ?, price = ? WHERE id = ?';
//   pool.query(query, [category_id, name, description, price, id], (err, results) => {
//     if (err) {
//       console.error(err);
//       res.status(500).send('Internal Server Error');
//     } else {
//       if (results.affectedRows > 0) {
//         res.status(200).send('Product updated successfully');
//       } else {
//         res.status(404).send('Product not found');
//       }
//     }
//   });
}

const deleteProduct=(req,res)=>{
    const id= req.params.id;
    const query = 'UPDATE product SET isDeleted = true WHERE id = ?';
     pool.query(query, [id], (err, results) => {
    if (err) {
      console.error(err);
      res.status(500).send('Internal Server Error');
    } else {
      if (results.affectedRows > 0) {
        res.status(200).send('Product soft deleted successfully');
      } else {
        res.status(404).send('Product not found');
      }
    }
  });
}


module.exports={
    createProduct,
    getAllProducts,
    getSingleProduct,
    deleteProduct,
    updateProduct
};