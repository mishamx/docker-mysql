# MySQL 5.7

## Master Slave 

```yaml

version: '2'

services:
    db:
        image: mishamx/mysql:5.7
        ports:
            - "3306:3306"
        environment:
            MYSQL_DATABASE: web
            MYSQL_USER: web
            MYSQL_PASSWORD: web
            MYSQL_ROOT_PASSWORD: testpass
            MYSQL_REPLICATION_USER: user_for_slave
            MYSQL_REPLICATION_PASSWORD: user_password_for_slave
        networks:
            - back

    db-slave:
        image: mishamx/mysql:5.7
        ports:
            - "3307:3306"
        environment:
            MYSQL_ROOT_PASSWORD: testpass
            MYSQL_MASTER_HOST: db
            MYSQL_MASTER_PORT: 3306
            MYSQL_REPLICATION_USER: user_for_slave
            MYSQL_REPLICATION_PASSWORD: user_password_for_slave
        networks:
            - back
        links:
            - db
        depends_on:
            - db

networks:
    front:
        driver: bridge
    back:
        driver: bridge

```