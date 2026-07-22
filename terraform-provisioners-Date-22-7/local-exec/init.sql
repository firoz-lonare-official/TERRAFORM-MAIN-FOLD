CREATE DATABASE company;

USE company;

CREATE TABLE employees (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100),
    department VARCHAR(50)
);

INSERT INTO employees (name, department)
VALUES ('Rahul', 'DevOps');