#! /bin/bash

TOMCAT_XMX=${TOMCAT_XMX:-128M}
TOMCAT_XMS=${TOMCAT_XMS:-64M}

# maven proxy
if [ ! -f $JENKINS_HOME/proxy.xml ]; then
  /opt/set_maven_proxy.sh
fi

# set tomcat admin user
cat > $CATALINA_HOME/conf/tomcat-users.xml <<-EOC
<?xml version='1.0' encoding='utf-8'?>
<tomcat-users>
  <user username="admin" password="password" roles="admin-gui,admin-script,manager-gui,manager-status,manager-script" />
</tomcat-users>
EOC

# run tomcat
export CATALINA_OPTS="-server -Xmx${TOMCAT_XMX} -Xms${TOMCAT_XMS} -Xss256k -Djava.awt.headless=true"
$CATALINA_HOME/bin/catalina.sh start
tail -f $CATALINA_HOME/logs/catalina.out

