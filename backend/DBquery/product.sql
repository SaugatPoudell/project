CREATE TABLE product (
    id INT PRIMARY KEY,
    category_id INT,
    name VARCHAR(255),
    description TEXT,
    product_image VARCHAR(255),
    price DECIMAL(10, 2),
    FOREIGN KEY (category_id) REFERENCES product_category(id)
);

ALTER TABLE product
DROP PRIMARY KEY;



ALTER TABLE product
ADD PRIMARY KEY (id);

ALTER TABLE product
MODIFY COLUMN id INT AUTO_INCREMENT;

ALTER TABLE product
ADD COLUMN isDeleted BOOLEAN DEFAULT FALSE;
