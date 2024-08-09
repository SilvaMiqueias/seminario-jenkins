# Use uma imagem base do OpenJDK do Docker Hub
FROM openjdk:17-jdk-alpine

# Defina o diretório de trabalho
WORKDIR /app

# Copie o JAR construído para a imagem
COPY build/libs/*.jar app.jar

# Exponha a porta em que a aplicação irá rodar
EXPOSE 8088

# Comando para executar a aplicação
ENTRYPOINT ["java", "-jar", "/app/app.jar"]