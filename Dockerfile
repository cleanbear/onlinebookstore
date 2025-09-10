# Stage 1: build
FROM maven:3.8.8-openjdk-17 AS builder
WORKDIR /app
COPY pom.xml .
COPY src ./src
RUN mvn -B -DskipTests clean package

# Stage 2: runtime
FROM openjdk:17-jdk-slim
WORKDIR /app
# copy the fat jar produced by Maven (adjust name/pattern if different)
COPY --from=builder /app/target/*.jar app.jar
EXPOSE 8080
ENTRYPOINT ["java", "-jar", "/app/app.jar"]
