# Use an official Maven image to build the application
FROM maven:3.8.6-openjdk-11 AS build

# Set the working directory
WORKDIR .

# Copy the pom.xml and download the dependencies
COPY pom.xml .
RUN mvn dependency:go-offline

# Copy the rest of the project files
COPY src ./src

# Package the application
RUN mvn clean package

# Use an official Tomcat image to deploy the application
FROM tomcat:9.0-jdk11

# Copy the packaged WAR file to the webapps directory of Tomcat
COPY --from=build /app/target/Online-Voting-System.war /usr/local/tomcat/webapps/Online-Voting-System.war

# Expose the port on which Tomcat is running
EXPOSE 8080
