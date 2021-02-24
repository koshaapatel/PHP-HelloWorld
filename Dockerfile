FROM php:7.2-apache
COPY hello.php /var/www/html/index.php
EXPOSE 8082
CMD ["/usr/sbin/apache2ctl", "-D", "FOREGROUND"]