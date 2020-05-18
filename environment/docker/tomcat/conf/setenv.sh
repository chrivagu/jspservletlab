#!/bin/sh
# Source all the files in /opt/middleware/tomcatA/tomcatA1/conf.d
JAVA_OPTS="${JAVA_OPTS} -Xms1024m -Xmx4096m -Xss1024k -XX:MaxPermSize=256m"
JAVA_OPTS="${JAVA_OPTS} -DTCAPP=tomcatA1"
JAVA_OPTS="${JAVA_OPTS} -DMW_NAME=tomcatA1"
JAVA_OPTS="${JAVA_OPTS} -DAPP_ENV=LOCAL"
JAVA_OPTS="${JAVA_OPTS} -DINSTANCE_SIDE=a"
JAVA_OPTS="${JAVA_OPTS} -DIS_LOCAL=true"

if [ -z ${CLASSPATH} ]
then
  CLASSPATH="/opt/middleware/application/tomcatA1/config/LOCAL"
else
  CLASSPATH="${CLASSPATH}:/opt/middleware/application/tomcatA1/config/LOCAL"
fi

CATALINA_OPTS="${CATALINA_OPTS} -Dfile.encoding=UTF-8"
CATALINA_OPTS="${CATALINA_OPTS} -agentlib:jdwp=transport=dt_socket,address=9457,server=y,suspend=n"

