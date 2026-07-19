Requirements

Create a Compose file with 2 services.

Service 1: app
Build using the Dockerfile in the current directory

Container name:

spring-app

Expose:

8080:8080
Depends on MySQL
Environment variables:
SPRING_DATASOURCE_URL=jdbc:mysql://mysql:3306/employeedb

SPRING_DATASOURCE_USERNAME=root

SPRING_DATASOURCE_PASSWORD=root123

Notice the hostname:

mysql

NOT

localhost
Service 2: mysql

Use image:

mysql:8.0

Container name:

mysql-db

Expose:

3306:3306

Environment variables:

MYSQL_ROOT_PASSWORD=root123

MYSQL_DATABASE=employeedb

Persist the database using a named volume called:

mysql-data

Mount it to:

/var/lib/mysql
Create a named volume

At the bottom of the file:

volumes:

You'll define the named volume there.