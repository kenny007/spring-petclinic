# Base image that includes the JDK
FROM openjdk:11-jre-slim

# Add application's jar file to the container
COPY target/spring-petclinic-*.jar /app.jar

# The command to run petclinic application
CMD ["java", "-jar", "/app.jar"]
