######
#
# During startup a directory specified by the environment variable `DEPLOY_DIR`
# (*/maven* by default) is checked for .war files. If there
# are any, they are linked into the *webapps/* directory for automatic
# deployment. This plays nicely with the Docker maven plugin from
# https://github.com/rhuss/docker-maven-plugin/ and its 'assembly' mode which
# can automatically create Docker data container with Maven artifacts
# exposed from a directory */maven*.
#
# >docker build -t base/tomcat_8 .
# >docker run -d -p 8080:8080 -p 8000:8000 --volumes-from data --name t8 base/tomcat_8
######

# From Java 8u45 official base image
FROM java:8u45

# Maintained by
MAINTAINER emanuguerra@sqli.com

# Expose HTTP + remote debug ports
EXPOSE 8080 8000

# Tomcat version
ENV TOMCAT_VERSION 8.0.21

# Directory for artifact deployment -> see docker-maven-plugin https://github.com/rhuss/docker-maven-plugin
ENV DEPLOY_DIR /maven

# Get and Unpack Tomcat
RUN wget http://archive.apache.org/dist/tomcat/tomcat-8/v${TOMCAT_VERSION}/bin/apache-tomcat-${TOMCAT_VERSION}.tar.gz -O /tmp/catalina.tar.gz && tar xzf /tmp/catalina.tar.gz -C /opt && ln -s /opt/apache-tomcat-${TOMCAT_VERSION} /opt/tomcat && rm /tmp/catalina.tar.gz

# Add roles
ADD tomcat-users.xml /opt/apache-tomcat-${TOMCAT_VERSION}/conf/

# Startup script
ADD deploy-and-run.sh /opt/apache-tomcat-${TOMCAT_VERSION}/bin/
RUN chmod +x /opt/apache-tomcat-${TOMCAT_VERSION}/bin/deploy-and-run.sh

# Remove unneeded apps
RUN rm -rf /opt/tomcat/webapps/examples /opt/tomcat/webapps/docs

VOLUME ["/opt/tomcat/logs", "/opt/tomcat/work", "/opt/tomcat/temp", "/tmp/hsperfdata_root" ]

ENV CATALINA_HOME /opt/tomcat
ENV PATH $PATH:$CATALINA_HOME/bin

# Default command to be executed when running the image
CMD ["/opt/tomcat/bin/deploy-and-run.sh"]
