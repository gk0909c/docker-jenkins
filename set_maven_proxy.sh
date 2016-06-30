#! /bin/bash

# get proxy info from jenkins proxy.xml
host=`echo "cat /proxy/name" | xmllint --shell $JENKINS_HOME/proxy.xml`
port=`echo "cat /proxy/port" | xmllint --shell $JENKINS_HOME/proxy.xml`
proxy_host=`echo ${host} | sed -e "s/^.*<name.*>\(.*\)<\/name>.*$/\1/"`
proxy_port=`echo ${port} | sed -e "s/^.*<port.*>\(.*\)<\/port>.*$/\1/"`

m2_dir=~/.m2

if [ ! -d $m2_dir ]; then
  mkdir $m2_dir
fi

# out maven settings.xml
cat > $m2_dir/settings.xml <<-EOC
<?xml version="1.0" encoding="UTF-8"?>
	<settings xmlns="http://maven.apache.org/SETTINGS/1.1.0" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
	  xsi:schemaLocation="http://maven.apache.org/SETTINGS/1.1.0 http://maven.apache.org/xsd/settings-1.1.0.xsd">
	  <proxies>
	    <proxy>
	      <id>http_proxy</id>
	      <active>true</active>
	      <protocol>http</protocol>
	      <host>$proxy_host</host>
	      <port>$proxy_port</port>
	    </proxy>
	    <proxy>
	      <id>https_proxy</id>
	      <active>true</active>
	      <protocol>https</protocol>
	      <host>$proxy_host</host>
	      <port>$proxy_port</port>
	    </proxy>
	  </proxies>
	</settings>
EOC
