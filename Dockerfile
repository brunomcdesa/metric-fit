FROM maven:3.9-eclipse-temurin-25 AS build
WORKDIR /app
COPY . .
RUN mvn clean package

FROM mcr.microsoft.com/openjdk/jdk:25-ubuntu
WORKDIR /app
EXPOSE 8080

ENV TZ=America/Sao_Paulo
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

COPY --from=build /app/target/MetricFit-*.jar app.jar

ENTRYPOINT ["java", "-jar", "app.jar"]