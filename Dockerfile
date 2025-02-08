# 1️⃣ Use an official OpenJDK image for building the JAR
FROM openjdk:17-jdk-slim as build

# Set the working directory
WORKDIR /app

# Copy the Maven wrapper and POM file first for better caching
COPY mvnw pom.xml ./
COPY .mvn .mvn

# Give execute permission to the Maven Wrapper
RUN chmod +x mvnw

# Download dependencies first (this allows caching of dependencies)
RUN ./mvnw dependency:go-offline

# Copy the rest of the source code
COPY src ./src

# Build the Spring Boot app (fat JAR)
RUN ./mvnw clean package -DskipTests

# 2️⃣ Use a smaller JDK runtime for the final image
FROM openjdk:17-jdk-slim

# Set working directory
WORKDIR /app

# Copy the JAR from the build stage
COPY --from=build /app/target/meet-x-0.0.1-SNAPSHOT.jar app.jar

# Expose the port Spring Boot runs on
EXPOSE 8080

# Run the application
ENTRYPOINT ["java", "-jar", "app.jar"]
