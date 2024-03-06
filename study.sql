CREATE DATABASE BitcoinTransactions;
USE BitcoinTransactions;
CREATE TABLE Trade (
    TransactionID INT PRIMARY KEY AUTO_INCREMENT,
    coin VARCHAR(255),
    price int not null,
    
);

ALTER TABLE Trade ADD COLUMN count INT NOT NULL;

select * from Trade;



