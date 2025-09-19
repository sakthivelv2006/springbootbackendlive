# Copy Maven wrapper and pom.xml first (for caching)
COPY mvnw .
COPY .mvn .mvn
COPY pom.xml .

# Make the Maven wrapper executable (this fixes the permission denied error)
RUN chmod +x mvnw

# Download dependencies
RUN ./mvnw dependency:go-offline

# Copy the rest of the project
COPY src ./src

# Package the app
RUN ./mvnw clean package -DskipTests

# Expose the port Spring Boot runs on
EXPOSE 8080

# Run the jar
CMD ["java", "-jar", "target/springbootbackendlive-0.0.1-SNAPSHOT.jar"]
