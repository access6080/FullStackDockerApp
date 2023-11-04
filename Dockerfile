FROM maven:latest as build

WORKDIR /app

COPY pom.xml .

#Install dependencies in pom.xml
RUN mvn dependency:go-offline -B

COPY src ./src

# Create jar file
RUN mvn package -DskipTests

# Use Alpine Linux as the base image
FROM alpine:latest

# Install Nginx
RUN apk --no-cache add nginx

# Create a directory to store web content
RUN mkdir -p /usr/share/nginx/html
COPY ./client/nginx/default.conf /etc/nginx/http.d/default.conf
COPY ./client /usr/share/nginx/html

# Install OpenJDK (Java) on Alpine Linux
RUN apk --no-cache add  openjdk17-jre

COPY --from=build  /app/target/fsda.jar  /app/fsda.jar

# Expose port 80 for Nginx
EXPOSE 80 2222 8080

# Expose port for 8080 for Spring Boot (Development Only)  -> Uncomment when needed
#EXPOSE 8080

# Start both Nginx and the Java application using supervisord
RUN apk --no-cache add supervisor
COPY supervisord.conf /etc/supervisord.conf
CMD ["/usr/bin/supervisord", "-c", "/etc/supervisord.conf"]
