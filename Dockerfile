# Use the official Maven image to build the app
FROM maven:3.8.6-openjdk-17-slim AS build

# Set the working directory in the container
WORKDIR /app

# Copy the project's pom.xml and source code to the container
COPY pom.xml .
COPY src ./src

# Build the application
RUN mvn clean package -DskipTests

# Use an OpenJDK runtime image
FROM openjdk:17-jdk-slim

# Set the working directory in the container
WORKDIR /app

# Copy the JAR file from the Maven image
COPY --from=build /app/target/*.jar app.jar

# Expose the port that your application will run on
EXPOSE 8080

# Run the application
ENTRYPOINT ["java", "-jar", "app.jar"]
