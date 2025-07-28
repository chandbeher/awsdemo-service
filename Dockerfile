# ─── BUILD STAGE ─────────────────────────────────────
FROM maven:3.9.8-eclipse-temurin-21 AS build

WORKDIR /workspace
COPY pom.xml .
COPY src ./src

RUN mvn clean package -DskipTests

# ─── RUNTIME STAGE ────────────────────────────────────
FROM openjdk:21-jre-alpine

WORKDIR /app
COPY --from=build /workspace/target/*.jar awsdemo-service.jar

EXPOSE 8080

ENTRYPOINT ["java", "-jar", "awsdemo-service.jar"]
