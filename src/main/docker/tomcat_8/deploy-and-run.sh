#!/bin/sh
echo "Starting tomcat ..."
DIR=${DEPLOY_DIR:-/maven}
echo "Checking *.war in $DIR"
if [ -d $DIR ]; then
  for i in $DIR/*.war ;
  do
     file=$(basename $i)
     echo "Linking $i --> /opt/tomcat/webapps/$file"
     ln -s $i /opt/tomcat/webapps/$file
  done
fi

# Add remote debug options on port 8000
export CATALINA_OPTS="$CATALINA_OPTS -Xdebug -Xrunjdwp:transport=dt_socket,address=8000,server=y,suspend=n"
/opt/tomcat/bin/catalina.sh run
