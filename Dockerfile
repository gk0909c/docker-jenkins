FROM gk0909c/ubuntu
MAINTAINER gk0909c@gmail.com

# install JDK
RUN wget --header "Cookie: oraclelicense=accept-securebackup-cookie" http://download.oracle.com/otn-pub/java/jdk/8u92-b14/jdk-8u92-linux-x64.tar.gz && \
    tar zxf jdk-8u92-linux-x64.tar.gz && \
    mv jdk1.8.0_92 /usr/local/ && \
    rm jdk-8u92-linux-x64.tar.gz
ENV JAVA_HOME /usr/local/jdk1.8.0_92

# install maven
RUN wget http://apache.cs.utah.edu/maven/maven-3/3.3.9/binaries/apache-maven-3.3.9-bin.tar.gz && \
    tar -zxf apache-maven-3.3.9-bin.tar.gz && \
    mv apache-maven-3.3.9 /usr/local && \
    rm apache-maven-3.3.9-bin.tar.gz
ENV MAVEN_HOME /usr/local/apache-maven-3.3.9

# install tomcat
RUN wget http://ftp.riken.jp/net/apache/tomcat/tomcat-8/v8.0.36/bin/apache-tomcat-8.0.36.tar.gz && \
    tar zxf apache-tomcat-8.0.36.tar.gz && \
    mv apache-tomcat-8.0.36 /usr/local/ && \
    rm apache-tomcat-8.0.36.tar.gz
ENV CATALINA_HOME /usr/local/apache-tomcat-8.0.36

# install jenkins
RUN wget http://mirrors.jenkins-ci.org/war/2.11/jenkins.war && \
    mv jenkins.war ${CATALINA_HOME}/webapps/
ENV JENKINS_HOME /var/jenkins_home
RUN mkdir ${JENKINS_HOME}

# other software
RUN apt-get update && apt-get install -y git libxml2-utils fonts-vlgothic

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

