# Use an official OpenJDK runtime as a parent image
FROM openjdk:17-jdk-slim as build

# Set the working directory
WORKDIR /app

# Copy the local code to the container
COPY . /app

# Give execute permission to the mvnw script
RUN chmod +x mvnw

# Build the Spring Boot app
RUN ./mvnw clean package -DskipTests

# Run the Spring Boot app
ENTRYPOINT ["java", "-jar", "/app/target/meet-x-0.0.1-SNAPSHOT.jar"]

# Expose the port the app will run on
EXPOSE 8080
