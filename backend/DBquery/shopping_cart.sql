CREATE TABLE shopping_cart (
id INT AUTO_INCREMENT,
user_id INT,
CONSTRAINT pk_shopcart PRIMARY KEY (id),
CONSTRAINT fk_shopcart_user FOREIGN KEY (user_id) REFERENCES
users (id)
);