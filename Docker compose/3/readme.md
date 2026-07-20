New Requirements

For the Spring Boot service:

Build using the current Dockerfile.
Expose 8080:8080.
Use an .env file to load environment variables (instead of writing them inline).
Restart policy: unless-stopped.

For MySQL:

Persist data using a named volume.
Add a health check that verifies MySQL is accepting connections.

For Redis:

Use the redis:7-alpine image.
Expose port 6379.
Restart policy: always.


environment:
    DB_HOST: mysql

env_file:
    - .env

environment:
    DB_HOST : ${DB_HOST}