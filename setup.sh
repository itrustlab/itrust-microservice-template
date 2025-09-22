#!/bin/bash

# Setup script for iTrust microservice template
# This script helps customize the template for a new service

echo "🚀 Setting up new iTrust microservice from template..."
echo ""

# Get service details
read -p "Enter service name (e.g., user-service): " SERVICE_NAME
read -p "Enter service description: " SERVICE_DESCRIPTION
read -p "Enter service package (e.g., tz.co.itrust.services.user): " SERVICE_PACKAGE
read -p "Enter service port (default 8080): " SERVICE_PORT
SERVICE_PORT=${SERVICE_PORT:-8080}

echo ""
echo "📝 Configuration:"
echo "  Service Name: $SERVICE_NAME"
echo "  Description: $SERVICE_DESCRIPTION"
echo "  Package: $SERVICE_PACKAGE"
echo "  Port: $SERVICE_PORT"
echo ""

read -p "Continue with setup? (y/N): " CONFIRM
if [[ ! $CONFIRM =~ ^[Yy]$ ]]; then
    echo "Setup cancelled."
    exit 1
fi

echo ""
echo "🔄 Updating files..."

# Extract service name from package for directory structure
SERVICE_DIR=$(echo $SERVICE_PACKAGE | sed 's/.*\.//')

# Update POM file
echo "  - Updating pom.xml..."
sed -i.bak "s/microservice-template/$SERVICE_NAME/g" pom.xml
sed -i.bak "s/Template Service/$SERVICE_DESCRIPTION/g" pom.xml
sed -i.bak "s/tz.co.itrust.services.template/$SERVICE_PACKAGE/g" pom.xml
rm pom.xml.bak

# Update application properties
echo "  - Updating application.properties..."
sed -i.bak "s/microservice-template/$SERVICE_NAME/g" src/main/resources/application.properties
sed -i.bak "s/8080/$SERVICE_PORT/g" src/main/resources/application.properties
rm src/main/resources/application.properties.bak

# Update Dockerfile
echo "  - Updating Dockerfile..."
sed -i.bak "s/microservice-template/$SERVICE_NAME/g" Dockerfile
sed -i.bak "s/8080/$SERVICE_PORT/g" Dockerfile
rm Dockerfile.bak

# Rename package directories
echo "  - Renaming package directories..."
if [ -d "src/main/java/tz/co/itrust/services/template" ]; then
    mv "src/main/java/tz/co/itrust/services/template" "src/main/java/tz/co/itrust/services/$SERVICE_DIR"
fi

if [ -d "src/test/java/tz/co/itrust/services/template" ]; then
    mv "src/test/java/tz/co/itrust/services/template" "src/test/java/tz/co/itrust/services/$SERVICE_DIR"
fi

# Update package declarations in Java files
echo "  - Updating package declarations..."
find src -name "*.java" -exec sed -i.bak "s/tz.co.itrust.services.template/$SERVICE_PACKAGE/g" {} \;
find src -name "*.java" -exec sed -i.bak "s/TemplateApplication/${SERVICE_DIR^}Application/g" {} \;
find src -name "*.java" -exec sed -i.bak "s/Template Service/$SERVICE_DESCRIPTION/g" {} \;
find src -name "*.java" -exec sed -i.bak "s/microservice-template/$SERVICE_NAME/g" {} \;
find src -name "*.bak" -delete

# Rename main application class
if [ -f "src/main/java/tz/co/itrust/services/$SERVICE_DIR/TemplateApplication.java" ]; then
    mv "src/main/java/tz/co/itrust/services/$SERVICE_DIR/TemplateApplication.java" "src/main/java/tz/co/itrust/services/$SERVICE_DIR/${SERVICE_DIR^}Application.java"
fi

# Update README
echo "  - Updating README.md..."
sed -i.bak "s/microservice-template/$SERVICE_NAME/g" README.md
sed -i.bak "s/Template Service/$SERVICE_DESCRIPTION/g" README.md
sed -i.bak "s/tz.co.itrust.services.template/$SERVICE_PACKAGE/g" README.md
rm README.md.bak

echo ""
echo "✅ Setup complete!"
echo ""
echo "📋 Next steps:"
echo "  1. Review the updated files"
echo "  2. Run: mvn clean compile"
echo "  3. Run: mvn test"
echo "  4. Run: mvn spring-boot:run"
echo ""
echo "🎉 Your new microservice '$SERVICE_NAME' is ready!"
