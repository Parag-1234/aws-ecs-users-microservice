
# Stage 1: Build the application
FROM maven:3.9-eclipse-temurin-17 AS build

WORKDIR /app

COPY mvnw .
COPY .mvn .mvn
COPY pom.xml .

RUN chmod +x mvnw
RUN ./mvnw dependency:go-offline

COPY src ./src

RUN ./mvnw clean package -DskipTests

# Stage 2: Run the application
FROM amazoncorretto:17-alpine

WORKDIR /app

VOLUME /tmp

COPY --from=build /app/target/PhotoAppApiUsers-0.0.1-SNAPSHOT.jar users-microservice.jar

ENTRYPOINT ["java","-Djava.security.egd=file:/dev/./urandom","-jar","/app/users-microservice.jar"]
