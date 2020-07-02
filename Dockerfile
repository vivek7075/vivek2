FROM ubuntu:18.04
RUN export LANG=en_US.UTF-8
ENV DEBIAN_FRONTEND noninteractive
ENV INITRD No
RUN apt-get clean
RUN rm -r /var/lib/apt/lists/*
RUN apt-get update
ENV TZ=Asia/Kolkata
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone
RUN apt-get install apache2 -y
RUN apt-get install mysql-server mysql-client -y
RUN apt-get install php libapache2-mod-php php-mysql -y
RUN apt-get install phpmyadmin -y
RUN mkdir -p /var/lock/apache2
RUN mkdir -p /var/run/apache2
RUN ln -s /etc/phpmyadmin/apache.conf /etc/apache2/conf-available/phpmyadmin.conf
RUN a2enconf phpmyadmin
 
ENV APACHE_RUN_USER www-data
ENV APACHE_RUN_GROUP www-data
ENV APACHE_PID_FILE /var/run/apache2.pid
ENV APACHE_RUN_DIR /var/run/apache2
ENV APACHE_LOCK_DIR /var/lock/apache2
ENV APACHE_LOG_DIR /var/log/apache2
RUN rm /var/www/html/index.html
COPY index.php /var/www/html
COPY phpinfo.php /var/www/html

 
CMD ["/usr/sbin/apache2","-D","FOREGROUND"]
EXPOSE 80
