#!/bin/bash

if [ $# -ne 2 ]; then
  echo "Usage: $0 database-password file"
  exit 1
fi

# Получение директории скрипта
scriptDir=$(dirname "$(readlink -f "$0")")

# Проверка существования пользователя базы данных
usrExists=$(mariadb -u root -p"$1" -e "SELECT User FROM mysql.user WHERE User='traccar';" | grep traccar)

# Проверка существования базы данных
dbExists=$(mariadb -u root -p"$1" -e "SELECT SCHEMA_NAME FROM INFORMATION_SCHEMA.SCHEMATA WHERE SCHEMA_NAME='traccar';" | grep traccar)

# Повторное создание базы данных
if [ -z "$dbExists" ] || [ -z "$usrExists" ]; then
  mariadb -u root -p"$1" --force < "$scriptDir/db-setup-traccar-with-arg.sql"
fi

# Восстановление базы данных из копии
mariadb -u root -p"$1" traccar < "$2"

systemctl restart traccar.service

# Сообщение об успешном восстановлении базы данных
echo "База данных успешно восстановлена из файла $2"
