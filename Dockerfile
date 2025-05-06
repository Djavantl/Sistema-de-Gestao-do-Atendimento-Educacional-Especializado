
FROM maven:3.9.4-eclipse-temurin-17 AS build

WORKDIR /app


COPY pom.xml .


RUN mvn dependency:go-offline -B


COPY code/src/main ./src/main


RUN mvn clean package -DskipTests


FROM tomcat:10.1-jdk17-temurin


RUN rm -rf /usr/local/tomcat/webapps/*


COPY --from=build /app/target/*.war /usr/local/tomcat/webapps/ROOT.war


HEALTHCHECK --interval=30s --timeout=3s \
    CMD curl -f http://localhost:8080/ || exit 1

EXPOSE 8080

CMD ["catalina.sh", "run"]