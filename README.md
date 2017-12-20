# docker jenkins #
jenkins with maven

## include ##
+ openjdk8
+ maven3.5.0
+ tomcat8.5.15
+ jenkins 2.89.2

## usage ##
To run,
```
docker run -d -p 8080:8080 --name jenkins gk0909c/jenkins
```
and access to http://localhost:8080/jenkins/ with your browser.

To store data,
```
docker run -d -e -v /your/data/path:/var/jenkins_home -p 8080:8080 --name jenkins gk0909c/jenkins
```

To view unlock password(at first time, jenkins provide getting start wizard)
```
docker exec jenkins cat /var/jenkins_home/secrets/initialAdminPassword
```

To set maven proxy, this should be executed after jenkins proxy setting.  
(This read proxy info from $JENKINS_HOME/proxy.xml)
```
docker exec jenkins /opt/set_maven_proxy.sh
```

## tomcat admin user
admin/password

## environment variables(const)
+ JAVA_HOME: /usr/lib/jvm/java-8-openjdk-amd64
+ MAVEN_HOME: /usr/local/apache-maven-3.5.0
+ CATALINA_HOME: /usr/local/apache-tomcat-8.5.15
+ JENKINS_HOME: /var/jenkins_home

## environment variables(you can specify at run -e param)
+ TOMCAT_XMX: 512M (Default)
+ TOMCAT_XMS: 256M (Default)
+ TOMCAT_ENCODING: UTF-8 (Default)
