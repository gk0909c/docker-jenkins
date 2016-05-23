#! /bin/bash

# JAVA_HOME
cat > config.xml <<EOF
<?xml version='1.0' encoding='UTF-8'?>
<hudson>
  <jdks>
    <jdk>
      <name>jdk8</name>
      <home>$JAVA_HOME</home>
      <properties/>
    </jdk>
  </jdks>
</hudson>
EOF

# MAVEN_HOME
cat > hudson.tasks.Maven.xml <<EOF
<?xml version='1.0' encoding='UTF-8'?>
<hudson.tasks.Maven_-DescriptorImpl>
  <installations>
    <hudson.tasks.Maven_-MavenInstallation>
      <name>maven3.3.3</name>
      <home>$M2_HOME</home>
      <properties/>
    </hudson.tasks.Maven_-MavenInstallation>
  </installations>
</hudson.tasks.Maven_-DescriptorImpl>
EOF

# proxy
if [ -v PROXY_HOST ]; then
	# for plugin install
	cat  > proxy.xml <<-EOF
	<?xml version='1.0' encoding='UTF-8'?>
	<proxy>
	  <name>$PROXY_HOST</name>
	  <port>$PROXY_PORT</port>
	  <noProxyHost>localhost</noProxyHost>
	</proxy>
	EOF
	
	# for maven
  cp $M2_HOME/conf/settings.xml $M2_HOME/conf/settings.xml.org
	cat > $M2_HOME/conf/settings.xml <<-EOF
	<?xml version="1.0" encoding="UTF-8"?>
	<settings xmlns="http://maven.apache.org/SETTINGS/1.1.0" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
	  xsi:schemaLocation="http://maven.apache.org/SETTINGS/1.1.0 http://maven.apache.org/xsd/settings-1.1.0.xsd">
	  <proxies>
	    <proxy>
	      <id>http_proxy</id>
	      <active>true</active>
	      <protocol>http</protocol>
	      <host>$PROXY_HOST</host>
	      <port>$PROXY_PORT</port>
	    </proxy>
	    <proxy>
	      <id>https_proxy</id>
	      <active>true</active>
	      <protocol>https</protocol>
	      <host>$PROXY_HOST</host>
	      <port>$PROXY_PORT</port>
	    </proxy>
	  </proxies>
	</settings>
EOF
fi

# install plugins
PLUGIN_DIR=plugins
mkdir $PLUGIN_DIR

cat $PLUGINS_TXT | while read LINE;do
  curl -sSL -f https://updates.jenkins-ci.org/download/plugins/$LINE/latest/$LINE.hpi -o $PLUGIN_DIR/$LINE.hpi
  unzip -qqt $PLUGIN_DIR/$LINE.hpi
done

# run jenkins
java -Dfile.encoding=UTF-8 -Dsun.jnu.encoding=UTF-8 \
    -Dhudson.model.DirectoryBrowserSupport.CSP="default-src 'none'; \
        img-src 'self'; style-src 'self' 'unsafe-inline'; child-src 'self'; frame-src 'self';" \
    -jar /usr/share/jenkins/jenkins.war

