@echo off
setlocal enabledelayedexpansion

REM Setup script for iTrust microservice template (Windows)
REM This script helps customize the template for a new service

echo 🚀 Setting up new iTrust microservice from template...
echo.

REM Get service details
set /p SERVICE_NAME="Enter service name (e.g., user-service): "
set /p SERVICE_DESCRIPTION="Enter service description: "
set /p SERVICE_PACKAGE="Enter service package (e.g., tz.co.itrust.services.user): "
set /p SERVICE_PORT="Enter service port (default 8080): "

if "%SERVICE_PORT%"=="" set SERVICE_PORT=8080

echo.
echo 📝 Configuration:
echo   Service Name: %SERVICE_NAME%
echo   Description: %SERVICE_DESCRIPTION%
echo   Package: %SERVICE_PACKAGE%
echo   Port: %SERVICE_PORT%
echo.

set /p CONFIRM="Continue with setup? (y/N): "
if /i not "%CONFIRM%"=="y" (
    echo Setup cancelled.
    exit /b 1
)

echo.
echo 🔄 Updating files...

REM Extract service name from package for directory structure
for /f "tokens=* delims=" %%a in ('echo %SERVICE_PACKAGE% ^| powershell -command "$input -split '\.' | Select-Object -Last 1"') do set SERVICE_DIR=%%a

REM Update POM file
echo   - Updating pom.xml...
powershell -command "(Get-Content pom.xml) -replace 'microservice-template', '%SERVICE_NAME%' | Set-Content pom.xml"
powershell -command "(Get-Content pom.xml) -replace 'Template Service', '%SERVICE_DESCRIPTION%' | Set-Content pom.xml"
powershell -command "(Get-Content pom.xml) -replace 'tz.co.itrust.services.template', '%SERVICE_PACKAGE%' | Set-Content pom.xml"

REM Update application properties
echo   - Updating application.properties...
powershell -command "(Get-Content src/main/resources/application.properties) -replace 'microservice-template', '%SERVICE_NAME%' | Set-Content src/main/resources/application.properties"
powershell -command "(Get-Content src/main/resources/application.properties) -replace '8080', '%SERVICE_PORT%' | Set-Content src/main/resources/application.properties"

REM Update Dockerfile
echo   - Updating Dockerfile...
powershell -command "(Get-Content Dockerfile) -replace 'microservice-template', '%SERVICE_NAME%' | Set-Content Dockerfile"
powershell -command "(Get-Content Dockerfile) -replace '8080', '%SERVICE_PORT%' | Set-Content Dockerfile"

REM Rename package directories
echo   - Renaming package directories...
if exist "src\main\java\tz\co\itrust\services\template" (
    move "src\main\java\tz\co\itrust\services\template" "src\main\java\tz\co\itrust\services\%SERVICE_DIR%"
)

if exist "src\test\java\tz\co\itrust\services\template" (
    move "src\test\java\tz\co\itrust\services\template" "src\test\java\tz\co\itrust\services\%SERVICE_DIR%"
)

REM Update package declarations in Java files
echo   - Updating package declarations...
for /r src %%f in (*.java) do (
    powershell -command "(Get-Content '%%f') -replace 'tz.co.itrust.services.template', '%SERVICE_PACKAGE%' | Set-Content '%%f'"
    powershell -command "(Get-Content '%%f') -replace 'TemplateApplication', '%SERVICE_DIR%Application' | Set-Content '%%f'"
    powershell -command "(Get-Content '%%f') -replace 'Template Service', '%SERVICE_DESCRIPTION%' | Set-Content '%%f'"
    powershell -command "(Get-Content '%%f') -replace 'microservice-template', '%SERVICE_NAME%' | Set-Content '%%f'"
)

REM Rename main application class
if exist "src\main\java\tz\co\itrust\services\%SERVICE_DIR%\TemplateApplication.java" (
    move "src\main\java\tz\co\itrust\services\%SERVICE_DIR%\TemplateApplication.java" "src\main\java\tz\co\itrust\services\%SERVICE_DIR%\%SERVICE_DIR%Application.java"
)

REM Update README
echo   - Updating README.md...
powershell -command "(Get-Content README.md) -replace 'microservice-template', '%SERVICE_NAME%' | Set-Content README.md"
powershell -command "(Get-Content README.md) -replace 'Template Service', '%SERVICE_DESCRIPTION%' | Set-Content README.md"
powershell -command "(Get-Content README.md) -replace 'tz.co.itrust.services.template', '%SERVICE_PACKAGE%' | Set-Content README.md"

echo.
echo ✅ Setup complete!
echo.
echo 📋 Next steps:
echo   1. Review the updated files
echo   2. Run: mvn clean compile
echo   3. Run: mvn test
echo   4. Run: mvn spring-boot:run
echo.
echo 🎉 Your new microservice '%SERVICE_NAME%' is ready!

pause
