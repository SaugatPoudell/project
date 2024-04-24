CREATE TABLE otp (
    id INT PRIMARY KEY AUTO_INCREMENT,
    productId INT NOT NULL,
    value VARCHAR(255), -- Adjust the length as needed
    orderId INT NOT NULL,
    FOREIGN KEY (productId) REFERENCES product(id),
    FOREIGN KEY (orderId) REFERENCES orders(id)
);

ALTER TABLE otp
ADD COLUMN createdAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
ADD COLUMN expireAt TIMESTAMP DEFAULT NULL;

UPDATE otp
SET expireAt = createdAt + INTERVAL 2 MINUTE;


ALTER TABLE otp
ADD COLUMN userId INT,
ADD CONSTRAINT fk_otp_user FOREIGN KEY (userId) REFERENCES users(id);