
FROM amazoncorretto:17-alpine

WORKDIR /app

COPY target/PhotoAppApiUsers-0.0.1-SNAPSHOT.jar users-microservice.jar

EXPOSE 8081

ENTRYPOINT ["java", "-Djava.security.egd=file:/dev/./urandom", "-jar", "users-microservice.jar"]
