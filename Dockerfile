# This Dockerfile is for build a docker images from scratch with a specific Tomcat and java
ARG IMAGE_VERSION=v2
FROM centos

MAINTAINER cvg358@gmail.com

RUN mkdir /usr/local/tomcat
WORKDIR /usr/local/tomcat

RUN curl -O https://archive.apache.org/dist/tomcat/tomcat-8/v8.5.24/bin/apache-tomcat-8.5.24.tar.gz
RUN tar xvfz apache*.tar.gz
RUN mv apache-tomcat-8.5.24/* /usr/local/tomcat/.
#RUN cd /usr/local/tomcat/bin && ls -la
#RUN sudo yum -y update
RUN yum -y install java-1.8.0-openjdk
RUN java -version
RUN yum install zip unzip -y

### CLOUD DEPLOYMENT WARNING: Not working for Local deployment, however, in cloud deployment should be true
ENV ENABLE_SECURE_PORTS="false"

# Copy all required files to enable JSP loading in the tc8jre8 image
COPY environment/docker/tomcat/conf/context.xml \
     environment/docker/tomcat/conf/server.xml \
     /usr/local/tomcat/conf/

# Copy setenv with environment variables for PCS-UI
COPY environment/docker/tomcat/conf/setenv.sh \ /usr/local/tomcat/bin/


### CLOUD DEPLOYMENT WARNING: Generating the key for HTTPS. The ENABLE_SECURE_PORTS could enable the HTTPS ports.
###                           For cloud, this should be removed and the ENABLE_SECURE_PORTS should be true
RUN $JAVA_HOME/bin/keytool -genkey \
    -noprompt \
    -dname "CN=localhost.com, OU=SBC-DLP, O=Disney, L=Orlando, S=Florida, C=US" \
    -alias tomcat \
    -keyalg RSA \
    -keypass changeit \
    -storepass changeit

# Installing WAR files. WAR FILES SHOULD BE MOVED LATER AS VOLUME
COPY target/MyJspServletFromScratch-0.war /usr/local/tomcat/webapps/

### CLOUD DEPLOYMENT WARNING: Run tomcat

CMD ["/usr/local/tomcat/bin/catalina.sh", "run"]