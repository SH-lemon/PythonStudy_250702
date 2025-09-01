create database ecommerce_v1;
use ecommerce_v1;
desc product;
select * from product;

CREATE DATABASE ecommerce_v2;
USE ecommerce_v2;

CREATE TABLE teddyproducts (
	ID INT UNSIGNED NOT NULL AUTO_INCREMENT,
    TITLE VARCHAR(200) NOT NULL,
    CATEGORY VARCHAR(20) NOT NULL,
    PRIMARY KEY(ID)
);

DESC teddyproducts;
select * from teddyproducts;
