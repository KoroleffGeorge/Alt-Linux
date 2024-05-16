CREATE DATABASE traccar CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
CREATE USER 'traccar'@'localhost' IDENTIFIED BY '@psswd';
GRANT ALL PRIVILEGES ON traccar.* TO 'traccar'@'localhost' IDENTIFIED BY '@psswd' WITH GRANT OPTION;
FLUSH PRIVILEGES;
