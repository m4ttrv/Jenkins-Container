FROM jenkins/jenkins:2.190.2 
USER root 
COPY plugins.txt /usr/share/jenkins/ref/plugins.txt 
RUN /usr/local/bin/install-plugins.sh < /usr/share/jenkins/ref/plugins.txt 
