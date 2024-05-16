#!/bin/bash

if [ $# -ne 2 ]; then
  echo "Usage: $0 database-password user-password"
  exit 1
fi

# Создание установочных файлов
sed -e "s/@psswd/$2/g" db-setup-traccar.sql > db-setup-traccar-with-arg.sql
sed -e "s/@psswd/$2/g" traccar-config.xml > traccar.xml

# Создание базы данных для приложения
mariadb -u root -p"$1" < db-setup-traccar-with-arg.sql

# Обновление пакетов
apt-get update

# Создание пользователя
/usr/sbin/useradd -ms /bin/bash traccar

# Установка unzip
apt-get install unzip mc java-11-openjdk -y

# Установка Traccar
wget https://github.com/traccar/traccar/releases/download/v4.14/traccar-linux-64-4.14.zip
unzip traccar-linux-64-4.14.zip
./traccar.run
mv traccar.xml /opt/traccar/conf -f
chown -R traccar:traccar /opt/traccar
chmod -R 755 /opt/traccar

# Запуск и включение автозагрузки Traccar
systemctl daemon-reload
systemctl enable traccar.service
systemctl start traccar.service

echo "Установка Traccar GPS Tracking System завершена!"
