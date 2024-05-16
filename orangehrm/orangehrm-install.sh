#!/bin/bash

if [ $# -ne 2 ]; then
  echo "Usage: $0 database-password user-password"
  exit 1
fi

# Создание установочного файла
sed -e "s/@psswd/$2/g" db-setup-orangehrm.sql > db-setup-orangehrm-with-arg.sql

# Создание базы данных для приложения
mariadb -u root -p"$1" < db-setup-orangehrm-with-arg.sql

# Обновление пакетов
apt-get update

# Установка Apache и PHP
apt-get install apache2 apache2-httpd-prefork apache2-mod_ssl -y
apt-get install php7 apache2-mod_php7 php7-mbstring php7-intl php7-mysqli php7-zip php7-curl php7-soap php7-gd php7-xmlrpc php7-mcrypt php7-xmlreader php7-pdo_mysql php7-pdo -y

# Запуск и включение автозагрузки Apache
systemctl enable httpd2.service
systemctl start httpd2.service

# Конфигурация PHP
sed -i 's/;file_uploads = Off/file_uploads = On/' /etc/php/7.4/cli/php.ini
sed -i 's/;allow_url_fopen = Off/allow_url_fopen = On/' /etc/php/7.4/cli/php.ini
sed -i 's/memory_limit = 128M/memory_limit = 256M/' /etc/php/7.4/cli/php.ini
sed -i 's/upload_max_filesize = 20M/upload_max_filesize = 100M/' /etc/php/7.4/cli/php.ini
sed -i 's/;date.timezone =/date.timezone = Russia\/Moscow/' /etc/php/7.4/cli/php.ini

if grep "extension=pdo" /etc/php/7.4/cli/php.ini
then
    echo "Расширение pdo уже существует в файле php.ini"
else
   echo "extension=pdo" >> /etc/php/7.4/cli/php.ini
fi

# Установка OrangeHRM
apt-get install unzip -y
wget https://sourceforge.net/projects/orangehrm/files/latest/download -O orangehrm.zip
unzip orangehrm.zip
mv orangehrm-5.6.1 /var/www/html/orangehrm
chown -R apache2:apache2 /var/www/html/orangehrm
chmod -R 755 /var/www/html/orangehrm/
mv orangehrm.conf /etc/httpd2/conf/sites-available/

/usr/sbin/a2ensite orangehrm
/usr/sbin/a2enmod rewrite

# Перезапуск Apache
systemctl restart httpd2.service

echo "Установка OrangeHRM завершена!"
