#!/bin/bash

# Run all tests
mvn test --no-transfer-progress --fail-at-end -D org.slf4j.simpleLogger.showDateTime=true -D org.slf4j.simpleLogger.dateTimeFormat=HH:mm:ss

# Package the Spring Boot starter
cd tools/test-spring-boot-starter
mvn package -D skipTests --no-transfer-progress

# Run the Spring Boot application
java -jar target/test-spring-boot*.jar