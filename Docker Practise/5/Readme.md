Requirements
Build Stage
Use maven:3.9-eclipse-temurin-21

Build the JAR using:
./mvnw clean package -DskipTests

Runtime Stage
Use eclipse-temurin:21-jre
Set WORKDIR to /app
Create a user named springuser.
Run the application as springuser.
Copy the JAR from the build stage as app.jar.
Expose port 8080.

Start the application with:

java -jar app.jar