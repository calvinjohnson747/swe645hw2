# Use the official Tomcat base image
FROM tomcat:latest

# Set the working directory to the Tomcat webapps directory
WORKDIR /usr/local/tomcat/webapps/

# Copy the WAR file into the webapps directory
COPY mavenproject1-1.0-SNAPSHOT.war .

# Expose port 8080 for Tomcat
EXPOSE 8080

# Command to start Tomcat
CMD ["catalina.sh", "run"]
