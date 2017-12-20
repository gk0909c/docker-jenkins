FROM gk0909c/ubuntu
MAINTAINER gk0909c@gmail.com

# software
RUN apt-get update && apt-get install -y libxml2-utils fonts-vlgothic libltdl-dev

# install JDK
RUN apt-get install -y openjdk-8-jdk

# install maven
RUN wget https://archive.apache.org/dist/maven/maven-3/3.5.0/binaries/apache-maven-3.5.0-bin.tar.gz && \
    tar -zxf apache-maven-3.5.0-bin.tar.gz && \
    mv apache-maven-3.5.0 /usr/local && \
    rm apache-maven-3.5.0-bin.tar.gz

# install tomcat
RUN wget https://archive.apache.org/dist/tomcat/tomcat-8/v8.5.15/bin/apache-tomcat-8.5.15.tar.gz && \
    tar zxf apache-tomcat-8.5.15.tar.gz && \
    mv apache-tomcat-8.5.15 /usr/local/ && \
    rm apache-tomcat-8.5.15.tar.gz

# constant env
ENV JAVA_HOME="/usr/lib/jvm/java-8-openjdk-amd64" \
    MAVEN_HOME="/usr/local/apache-maven-3.5.0" \
    CATALINA_HOME="/usr/local/apache-tomcat-8.5.15" \
    JENKINS_HOME="/var/jenkins_home"

# install jenkins
RUN wget http://mirrors.jenkins.io/war-stable/2.89.2/jenkins.war && \
    mv jenkins.war ${CATALINA_HOME}/webapps/
RUN mkdir ${JENKINS_HOME}

# set font
RUN mkdir -p $JAVA_HOME/jre/lib/fonts/fallback/ && \
    ln -s /usr/share/fonts/truetype/vlgothic/VL-Gothic-Regular.ttf $JAVA_HOME/jre/lib/fonts/fallback/

# setting
COPY entrypoint.sh /opt/entrypoint.sh
COPY set_maven_proxy.sh /opt/set_maven_proxy.sh
RUN chmod 755 /opt/entrypoint.sh && \
    chmod 755 /opt/set_maven_proxy.sh

EXPOSE 8080

WORKDIR ${JENKINS_HOME}
ENTRYPOINT ["/opt/entrypoint.sh"]

