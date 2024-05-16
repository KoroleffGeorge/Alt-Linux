#!/bin/bash

if [ $# -ne 2 ]; then
  echo "Usage: $0 database-password directory"
  exit 1
fi

# Создание каталога для сохранения копии, если он не существует
mkdir -p "$2"

# Получение текущей даты в формате ГГГГ-ММ-ДД
date=$(date +"%Y-%m-%d")

# Выполнение mysqldump и сохранение копии в файл
mariadb-dump -u root -p"$1" orangehrm > "$2/orangehrm-data-dump-$date.sql"

# Сообщение об успешном создании копии
echo "Копия базы данных успешно создана в файле " "$2/orangehrm-data-dump-$date.sql"
