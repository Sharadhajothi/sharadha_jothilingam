FROM maven:3.9-eclipse-temurin-21 AS builder

WORKDIR /build

COPY pom.xml .
COPY mvnw .
COPY .mvn .mvn

RUN ./mvnw dependency:go-offline

COPY src src

RUN ./mvnw clean package -DskipTests

FROM eclipse-temurin:21-jre

WORKDIR /app

RUN useradd -r -u 1001 springuser

COPY --from=builder --chown=springuser:springuser /build/target/*.jar app.jar

USER springuser

EXPOSE 8080

CMD ["java","-jar","app.jar"]