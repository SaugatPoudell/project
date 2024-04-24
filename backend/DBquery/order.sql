CREATE TABLE orders (
    id INT PRIMARY KEY AUTO_INCREMENT,
    userId INT,
    order_date DATE,
    total DECIMAL(10, 2),
    productId INT,
    FOREIGN KEY (userId) REFERENCES users(id),
    FOREIGN KEY (productId) REFERENCES product(id)
);


ALTER TABLE orders
ADD COLUMN otpVerified BOOLEAN DEFAULT FALSE;

ALTER TABLE orders MODIFY order_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP;
ALTER TABLE orders
ADD COLUMN otp INT;