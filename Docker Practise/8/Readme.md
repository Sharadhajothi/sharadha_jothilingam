The pod status is:

CrashLoopBackOff

The image was built using this Dockerfile:

FROM eclipse-temurin:21-jre

WORKDIR /app

RUN useradd -r -u 1001 springuser

USER springuser

COPY target/demo.jar app.jar

EXPOSE 8080

CMD ["java","-jar","app.jar"]

The application fails immediately with:

Error: Unable to access jarfile app.jar