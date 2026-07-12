FROM eclipse-temurin:21-jre

WORKDIR /app

RUN useradd -r -u 1001 springuser

COPY --chown=springuser:springuser target/*.jar app.jar

USER springuser

EXPOSE 8080

CMD ["java","-jar","app.jar"]