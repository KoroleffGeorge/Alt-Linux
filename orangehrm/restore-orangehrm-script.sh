#!/bin/bash

if [ $# -ne 2 ]; then
  echo "Usage: $0 database-password file"
  exit 1
fi

# Получение директории скрипта
scriptDir=$(dirname "$(readlink -f "$0")")

# Проверка существования пользователя базы данных
usrExists=$(mariadb -u root -p"$1" -e "SELECT User FROM mysql.user WHERE User='orangehrmuser';" | grep orangehrmuser)

# Проверка существования базы данных
dbExists=$(mariadb -u root -p"$1" -e "SELECT SCHEMA_NAME FROM INFORMATION_SCHEMA.SCHEMATA WHERE SCHEMA_NAME='orangehrm';" | grep orangehrm)

# Повторное создание базы данных
if [ -z "$dbExists" ] || [ -z "$usrExists" ]; then
  mariadb -u root -p"$1" --force < "$scriptDir/db-setup-orangehrm-with-arg.sql"
fi

# Восстановление базы данных из копии
mariadb -u root -p"$1" orangehrm < "$2"

systemctl restart httpd2.service

# Сообщение об успешном восстановлении базы данных
echo "База данных успешно восстановлена из файла $2"
