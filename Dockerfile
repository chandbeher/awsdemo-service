# ─── BUILD STAGE ─────────────────────────────────────
FROM maven:3.9.8-eclipse-temurin-21 AS build

WORKDIR /workspace
COPY pom.xml .
COPY src ./src

RUN mvn clean package -DskipTests

# ─── RUNTIME STAGE ────────────────────────────────────
FROM amazoncorretto:21-alpine-jdk

WORKDIR /app
COPY --from=build /workspace/target/*.jar awsdemo-service.jar

EXPOSE 8080

ENTRYPOINT ["java", "-jar", "awsdemo-service.jar"]
