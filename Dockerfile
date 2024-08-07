# Etapa 1: Construcción
FROM gradle:8.0-jdk17 AS builder


RUN curl -fsSLO https://get.docker.com/builds/Linux/x86_64/docker-17.04.0-ce.tgz \
  && tar xzvf docker-17.04.0-ce.tgz \
  && mv docker/docker /usr/local/bin \
  && rm -r docker docker-17.04.0-ce.tgz


# Establece el directorio de trabajo
WORKDIR /app

# Copia el archivo de configuración de Gradle y el código fuente
COPY build.gradle settings.gradle /app/
COPY src /app/src/

# Construye la aplicación
RUN gradle build --no-daemon

# Etapa 2: Ejecutar
FROM openjdk:17-jdk-slim

# Establece el directorio de trabajo
WORKDIR /app

# Copia el archivo JAR construido desde la etapa de construcción
COPY --from=builder /app/build/libs/your-app.jar /app/your-app.jar

# Expone el puerto en el que se ejecutará la aplicación
EXPOSE 8088

# Comando para ejecutar la aplicación
ENTRYPOINT ["java", "-jar", "/app/your-app.jar"]