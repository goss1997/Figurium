FROM openjdk:17-jdk-slim
ADD figurium/build/libs/*.war app.war
ENTRYPOINT ["java","-Djava.security.egd=file:/dev/./urandom","-jar","/app.war"]
