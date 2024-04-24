
use ecommerce;

CREATE TABLE users (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255),
    email VARCHAR(255) NOT NULL,
    role VARCHAR(255) DEFAULT 'subscriber',
    address VARCHAR(255)

)
-- Add 'createdAt' column
ALTER TABLE users
ADD COLUMN createdAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP;

-- Add 'updatedAt' column
ALTER TABLE users
ADD COLUMN updatedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP;

-- Add 'isDeleted' column
ALTER TABLE users
ADD COLUMN isDeleted BOOLEAN DEFAULT false;

-- Add 'password' column with NOT NULL constraint
ALTER TABLE users
ADD COLUMN password VARCHAR(255) NOT NULL;
