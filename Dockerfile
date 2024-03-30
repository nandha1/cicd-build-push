FROM openjdk:17
WORKDIR /appContainer
ADD /target/jenkinsCiCd.jar /appContainer
EXPOSE 8282
ENTRYPOINT ["java","-jar","jenkinsCiCd.jar"]


#FROM openjdk:17
#WORKDIR /appContainer
#COPY ./target/jenkinsCiCd.jar /appContainer
#EXPOSE 8282
#CMD ["java","-jar","jenkinsCiCd.jar"]
#
#FROM openjdk:17
## from target jar to docker image
#ADD /target/spring-docker.jar docker-image.jar
#EXPOSE 8282
#ENTRYPOINT ["java","-jar","docker-image.jar"]
