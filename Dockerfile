# Use an official OpenJDK runtime as a parent image
FROM openjdk:17-jdk-slim as build

# Set the working directory
WORKDIR /app

# Copy the local code to the container
COPY . /app

# Build the Spring Boot app
RUN ./mvnw clean package -DskipTests

# Run the Spring Boot app
ENTRYPOINT ["java", "-jar", "/app/target/your-app.jar"]

# Expose the port the app will run on
EXPOSE 8080
