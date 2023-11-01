# Use Maven base image for building the Spring Boot app
FROM maven:3.8.4 as maven-builder

# Copy the source code and pom.xml to the container
WORKDIR /app

# Copy the Maven project file
COPY pom.xml .

# Download and cache Maven dependencies
RUN mvn dependency:go-offline -B

COPY src ./src

# Build the application with Maven
RUN mvn package -DskipTests

# Use Alpine Linux as the base image again
FROM alpine:latest

# Install NGINX
RUN apk --no-cache add nginx


# Install OpenJDK (Java) on Alpine Linux
RUN apk --no-cache add  openjdk17-jre

# Copy the compiled Spring Boot JAR file from the maven-builder stage
COPY --from=maven-builder /app/target/fsda.jar /app/fsda.jar

# Set up NGINX configuration and copy client files
COPY ./client /usr/share/nginx/html
COPY ./client/nginx/default.conf /etc/nginx/http.d/default.conf

# Expose port 80 for NGINX
EXPOSE 80

# Expose port 8080 for Spring Boot
EXPOSE 8080

# Start NGINX and Spring Boot
COPY start.sh /start.sh
RUN chmod +x /start.sh
CMD ["/start.sh"]