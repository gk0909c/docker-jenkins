# docker jenkins #
jenkins ci server

## usage ##
+ jdk8
+ maven3.3.3
+ git plugin
+ jacoco plugin

To run,
```
docker run -d -p 8080:8080 --name jenkins gk0909c/jenkins
```

If you're behind proxy,
```
docker run -d -e PROXY_HOST=your.proxy.host -e PROXY_PORT=yourproxyport -p 8080:8080 --name jenkins gk0909c/jenkins
```

To store data,
```
docker run -d -e -v /your/data/path:/var/jenkins_home -p 8080:8080 --name jenkins gk0909c/jenkins
```

