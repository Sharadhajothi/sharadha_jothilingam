Requirements

Write a multi-stage Dockerfile.

Stage 1 (Build):

Use maven:3.9-eclipse-temurin-21
Set WORKDIR to /build
Copy the project files.

Run:

./mvnw clean package -DskipTests

Stage 2 (Runtime):

Use eclipse-temurin:21-jre
Set WORKDIR to /app
Copy the generated JAR from the build stage as app.jar.
Expose port 8080.

Run:

java -jar app.jar

Bonus (optional): Name your stages (for example, AS builder) and use COPY --from=<stage>