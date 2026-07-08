FROM maven:3.9-eclipse-temurin-21 AS Builder
WORKDIR /build
COPY . .
RUN ./mvnw clean package -DskipTests

FROM eclipse-temurin:21-jre
WORKDIR /app
RUN useradd -r -u 1001 springuser    /* useradd or adduser, -u 1001 sets a specific user ID */
COPY --from=Builder --chown=springuser:springuser /build/target/*.jar app.jar
USER springuser
EXPOSE 8080
CMD ["java", "-jar", "app.jar"]