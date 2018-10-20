FROM php:7.1-fpm
ADD appdynamics-php-agent-linux_x64/appdynamics-php-agent-linux_x64.tar.bz2 /opt/
ADD installAndStart.sh /usr/local/bin/installAndStart.sh
RUN chmod u+x /usr/local/bin/installAndStart.sh
#RUN apt-get update && apt-get install procps
ENTRYPOINT ["/usr/local/bin/installAndStart.sh"]
