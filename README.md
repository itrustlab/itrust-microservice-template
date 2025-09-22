# iTrust Microservice Template

This is a template repository for creating new iTrust microservices. It includes all the necessary configurations, dependencies, and structure to quickly bootstrap a new service.

## 🚀 Quick Start

### Option 1: GitHub Template (Recommended)
1. Click the "Use this template" button on GitHub
2. Create a new repository from this template
3. Clone your new repository
4. Follow the setup instructions below

### Option 2: Clone and Customize
```bash
git clone <this-repository-url> my-new-service
cd my-new-service
```

## ⚙️ Setup Instructions

### 1. Update Project Configuration

Edit `pom.xml` and update these properties:
```xml
<properties>
    <service.artifactId>your-service-name</service.artifactId>
    <service.name>Your Service Name</service.name>
    <service.description>Description of your service</service.description>
    <service.package>tz.co.itrust.services.yourservice</service.package>
</properties>
```

### 2. Rename Package Structure

1. Rename the package directory:
   ```bash
   mv src/main/java/tz/co/itrust/services/template src/main/java/tz/co/itrust/services/yourservice
   mv src/test/java/tz/co/itrust/services/template src/test/java/tz/co/itrust/services/yourservice
   ```

2. Update package declarations in all Java files
3. Rename the main application class

### 3. Update Application Properties

Edit `src/main/resources/application.properties`:
```properties
server.port=8080
server.servlet.context-path=/your-service-name
spring.application.name=your-service-name
```

### 4. Build and Test

```bash
# Build the project
mvn clean compile

# Run tests
mvn test

# Package the application
mvn package

# Run the application
mvn spring-boot:run
```

## 📦 What's Included

### Dependencies
- ✅ **iTrust Spring Boot Starter** - Common configurations and dependencies
- ✅ **Spring Boot Web** - REST API capabilities
- ✅ **Spring Boot Data JPA** - Database integration
- ✅ **Spring Boot Validation** - Input validation
- ✅ **Spring Boot Test** - Testing framework

### Configuration
- ✅ **Centralized BOM** - Consistent dependency versions
- ✅ **Nexus Repository** - Deployment configuration
- ✅ **Docker Support** - Containerization ready
- ✅ **Health Checks** - Monitoring endpoints
- ✅ **Logging Configuration** - Structured logging

### Structure
```
src/
├── main/
│   ├── java/
│   │   └── tz/co/itrust/services/template/
│   │       ├── TemplateApplication.java
│   │       └── controller/
│   │           └── HelloController.java
│   └── resources/
│       └── application.properties
└── test/
    └── java/
        └── tz/co/itrust/services/template/
            └── controller/
                └── HelloControllerTest.java
```

## 🔧 Customization

### Adding Dependencies
Add service-specific dependencies to `pom.xml`:
```xml
<dependencies>
    <!-- Your custom dependencies here -->
    <dependency>
        <groupId>org.springframework.boot</groupId>
        <artifactId>spring-boot-starter-data-redis</artifactId>
    </dependency>
</dependencies>
```

### Database Configuration
Uncomment and configure database settings in `application.properties`:
```properties
spring.datasource.url=jdbc:postgresql://localhost:5432/your-db
spring.datasource.username=your-username
spring.datasource.password=your-password
```

### Docker Configuration
Update `Dockerfile` if needed:
```dockerfile
FROM openjdk:21-jdk-slim
WORKDIR /app
COPY target/your-service-*.jar app.jar
EXPOSE 8080
ENTRYPOINT ["java", "-jar", "app.jar"]
```

## 🚀 Deployment

### To Nexus Repository
```bash
mvn deploy -DskipTests
```

### Docker Build
```bash
docker build -t your-service:latest .
docker run -p 8080:8080 your-service:latest
```

## 📚 Available Endpoints

- **Health Check**: `GET /your-service-name/api/v1/health`
- **Hello**: `GET /your-service-name/api/v1/hello`
- **Actuator**: `GET /your-service-name/actuator/health`

## 🛠️ Development

### Adding New Controllers
1. Create controller class in `controller` package
2. Add `@RestController` annotation
3. Define endpoints with appropriate HTTP methods

### Adding Services
1. Create service class in `service` package
2. Add `@Service` annotation
3. Inject dependencies using constructor injection

### Adding Entities
1. Create entity class in `entity` package
2. Add JPA annotations
3. Create repository interface extending `JpaRepository`

## 📖 Documentation

- [Spring Boot Documentation](https://spring.io/projects/spring-boot)
- [iTrust Platform Documentation](internal-link)
- [Team Development Guidelines](internal-link)

## 🤝 Contributing

1. Follow the established code patterns
2. Add tests for new functionality
3. Update documentation as needed
4. Follow the team's coding standards

## 📞 Support

For questions or issues:
- Check the team documentation
- Ask in the team chat
- Create an issue in the repository

---

**Happy Coding! 🎉**
