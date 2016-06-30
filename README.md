# docker jenkins #
jenkins ci server

## include ##
+ jdk8 (u92)
+ maven3.3.9
+ tomcat8.0.36
+ jenkins2.11

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
(This read info from $JENKINS_HOME/proxy.xml)
```
docker exec jenkins /opt/set_maven_proxy.sh
```

## tomcat admin user
admin/password

## environment variables
+ JAVA_HOME: /usr/local/jdk1.8.0_92
+ MAVEN_HOME: /usr/local/apache-maven-3.3.9
+ CATALINA_HOME: /usr/local/apache-tomcat-8.0.36
+ JENKINS_HOME: /var/jenkins_home
+ CATALINA_OPTS: "-server -Xmx128M -Xms64M -Xss256k -Djava.awt.headless=true"
