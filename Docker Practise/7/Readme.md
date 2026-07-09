Your developer wrote the following Dockerfile for a Spring Boot application, but the CI pipeline reports that:

The image size is 1.2 GB.
Builds are very slow.
Security scan reports High: Running as root.
Every code change causes Maven dependencies to download again.

Here is the Dockerfile:

FROM maven:3.9-eclipse-temurin-21

WORKDIR /app

COPY . .

RUN mvn clean package

EXPOSE 8080

CMD ["java","-jar","target/demo.jar"]
Your Task

Rewrite this Dockerfile to fix all of the following:

✅ Use a multi-stage build.
✅ Improve Docker layer caching so Maven dependencies aren't downloaded every build.
✅ Skip tests during the image build.
✅ Use a smaller runtime image.
✅ Run as a non-root user.
✅ Copy only the JAR into the runtime image.
✅ Keep the application running on port 8080.