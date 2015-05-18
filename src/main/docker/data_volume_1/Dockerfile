######
#
# This is a sample data volume.
#
# >docker build -t data_volume_1 .
# >docker run --name data -d  data_volume_1
# >docker ps
# >
#
######

# Use same image as the container using the volume for better caching
FROM java:8u45

# Maintained by
MAINTAINER emanuguerra@sqli.com

RUN mkdir -p /maven

# Add Tomcat 8 webapp sample
ADD hello-world.war /maven/

VOLUME /maven
ENTRYPOINT /usr/bin/tail -f /dev/null