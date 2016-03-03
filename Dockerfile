FROM gk0909c/ubuntu
MAINTAINER gk0909c@gmail.com

# install JDK
RUN wget --header "Cookie: oraclelicense=accept-securebackup-cookie" http://download.oracle.com/otn-pub/java/jdk/8u60-b27/jdk-8u60-linux-x64.tar.gz && \
    tar zxvf jdk-8u60-linux-x64.tar.gz && \
    mv jdk1.8.0_60 /usr/local/ && \
    rm jdk-8u60-linux-x64.tar.gz
ENV JAVA_HOME /usr/local/jdk1.8.0_60

# install maven
RUN wget http://apache.cs.utah.edu/maven/maven-3/3.3.3/binaries/apache-maven-3.3.3-bin.tar.gz && \
    tar -zxf apache-maven-3.3.3-bin.tar.gz && \
    mv apache-maven-3.3.3 /usr/local && \
    rm apache-maven-3.3.3-bin.tar.gz
ENV M2_HOME /usr/local/apache-maven-3.3.3

# install jenkins
RUN wget -q -O - https://jenkins-ci.org/debian/jenkins-ci.org.key | sudo apt-key add - && \
    sh -c 'echo deb http://pkg.jenkins-ci.org/debian binary/ > /etc/apt/sources.list.d/jenkins.list' && \
    apt-get update && \
    apt-get install -y jenkins
ENV JENKINS_HOME /var/jenkins_home
RUN mkdir ${JENKINS_HOME}

# other software
RUN apt-get install -y git

# link settings
RUN ln -s -f /usr/local/jdk1.8.0_60/bin/java /usr/bin/java && \
    ln -s -f /usr/local/jdk1.8.0_60/bin/javac /usr/bin/javac && \
    ln -s /usr/local/apache-maven-3.3.3/bin/mvn /usr/bin/mvn

ENV PLUGINS_TXT /opt/plusins.txt
COPY entrypoint.sh /opt/entrypoint.sh
COPY plugins.txt ${PLUGINS_TXT}
RUN chmod 755 /opt/entrypoint.sh && chmod 444 ${PLUGINS_TXT}

EXPOSE 8080

WORKDIR ${JENKINS_HOME}
ENTRYPOINT ["/opt/entrypoint.sh"]

