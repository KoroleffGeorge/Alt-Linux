CREATE DATABASE orangehrm;
CREATE USER 'orangehrmuser'@'localhost' IDENTIFIED BY '@psswd';
GRANT ALL ON orangehrm.* TO 'orangehrmuser'@'localhost' IDENTIFIED BY '@psswd' WITH GRANT OPTION;
FLUSH PRIVILEGES;
