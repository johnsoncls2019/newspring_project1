#
# Build stage
#
FROM maven:3.6.0-jdk-11-slim AS build
COPY src /home/mchrist1/AchiStarTechnologies/newspring_project1/src
COPY pom.xml /home/mchrist1/AchiStarTechnologies/newspring_project1
RUN mvn -f /home/mchrist1/AchiStarTechnologies/newspring_project1/pom.xml clean package

#
# Package stage
#
FROM openjdk:11-jre-slim
COPY --from=build /home/app/target/demo-0.0.1-SNAPSHOT.war /usr/local/lib/demo.war
EXPOSE 5000
ENTRYPOINT ["java","-jar","/usr/local/lib/demo.war"]

