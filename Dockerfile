FROM tomcat:8-jdk8

RUN rm -rf /usr/local/tomcat/webapps/*

COPY webserv /usr/local/tomcat/webapps/webserv

EXPOSE 8080
