## Подробная инструкция к скрипту установки приложения: OrangeHRM
Сценарий: Установка OrangeHRM на сервер с помощью скрипта `orangehrm-install.sh`.

Целевая аудитория: Пользователи с базовыми знаниями Linux, желающие установить OrangeHRM на свой сервер.

Требования:

* Сервер с операционной системой Linux (SimplyLinux 10.2)
* Установленная база данных MariaDB или MySQL
* Доступ к учетной записи пользователя с правами администратора

### Возможный вариант установки базы данных MariaDB
Последующие команды рекомендуется выполнять от имени администратора

1. Установка MariaDB:
```
apt-get update
```
```
apt-get install mariadb-server mariadb-client -y
```

2. Запуск и включение автозагрузки MariaDB
```
systemctl enable mariadb.service
```
```
systemctl start mariadb.service
```

3. Безопасная установка MariaDB:
```
mariadb-secure-installation
```

```
Enter current password for root (enter for none): Press the Enter
Enable unix_socket authentication? [Y/n]: n
Set root password? [Y/n]: Y
New password: Enter password
Re-enter new password: Repeat password
Remove anonymous users? [Y/n]: Y
Disallow root login remotely? [Y/n]: Y
Remove test database and access to it? [Y/n]:  Y
Reload privilege tables now? [Y/n]:  Y
```

### Установка приложения

1. Откройте терминал и выполните следующие команды по скачиванию и распаковке установочных файлов:
```
wget https://github.com/KoroleffGeorge/Alt-Linux/archive/refs/tags/orangehrm-2.0.0.tar.gz
```
```
tar -xvf orangehrm-2.0.0.tar.gz
```
```
cd Alt-Linux-orangehrm-2.0.0
```

2. Перейдите в файл `/etc/my.cnf.d/server.cnf` с правами администратора и закомментируйте `skip-networking`

3. Перезапустите базу данных от имени администратора:
```
systemctl restart mariadb.service
```

4. Установка прав доступа:
```
chmod +x orangehrm-install.sh
```

5. Запуск скрипта от имени администратора:
Необходимо передать 2 аргумента: Ваш пароль от базы данных, пароль пользователя `orangehrmuser` от базы данных.
```
./orangehrm-install.sh agr1 arg2
```

6. Завершение:
* После успешной установки скрипт выведет сообщение о готовности к эксплуатации приложения.
* URL: http://localhost:80/installer/index.php/welcome

7. Сохранение прогресса работы приложения:
```
chmod +x copy-orangehrm-script.sh
```
Необходимо передать 2 аргумента: Ваш пароль от базы данных, абсолютный путь до директории включительно.
```
./copy-orangehrm-script.sh arg1 arg2
```

8. Восстановление предыдущего состояния базы данных:
```
chmod +x restore-orangehrm-script.sh
```
Необходимо передать 2 аргумента: Ваш пароль от базы данных, абсолютный путь до файла включительно, где хранится нужное Вам состояние базы данных.
```
./restore-orangehrm-script.sh arg1 arg2
```

### Донастройка приложения:
![Пример](/orangehrm/screenshots/orangehrm1.jpg)
![Пример](/screenshots/orangehrm2.jpg)
![Пример](/screenshots/orangehrm3.jpg)
![Пример](/screenshots/orangehrm4.jpg)
![Пример](/screenshots/orangehrm5.jpg)
![Пример](/screenshots/orangehrm6.jpg)
