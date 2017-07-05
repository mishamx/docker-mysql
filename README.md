# MySQL 5.7

Master-Slave
 
## Start master

```bash
docker run -d -p 3306:3306 \
  --name mysql_master \
  -e MYSQL_DATABASE=web \
  -e MYSQL_USER=web \
  -e MYSQL_PASSWORD=web \
  -e MYSQL_ROOT_PASSWORD=root_password \
  -e MYSQL_REPLICATION_USER=user_for_slave \
  -e MYSQL_REPLICATION_PASSWORD=user_password_for_slave \
  mishamx/mysql:5.7
```

## Start slave

```bash
docker run -d -p 3307:3306  \
  --name mysql_slave \
  -e MYSQL_MASTER_HOST=master \
  -e MYSQL_ROOT_PASSWORD=root_password \
  -e MYSQL_REPLICATION_USER=user_for_slave \
  -e MYSQL_REPLICATION_PASSWORD=user_password_for_slave \
  --link mysql_master:master \
  mishamx/mysql:5.7
```

 
### Check 

```docker exec -i mysql_master mysql -u web -pweb -D web -e "CREATE TABLE names(id INT AUTO_INCREMENT KEY, name VARCHAR(10));INSERT INTO names (name) VALUES ('test1'), ('test2');"```
 
## Docker Compose

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
            MYSQL_ROOT_PASSWORD: root_password
            MYSQL_REPLICATION_USER: user_for_slave
            MYSQL_REPLICATION_PASSWORD: user_password_for_slave
        networks:
            - back

    db-slave:
        image: mishamx/mysql:5.7
        ports:
            - "3307:3306"
        environment:
            MYSQL_ROOT_PASSWORD: root_password
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