# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    dockerfile                                         :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: canjugun <canjugun@student.42.fr>          +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2021/04/19 17:39:03 by canjugun          #+#    #+#              #
#    Updated: 2021/04/21 14:40:29 by canjugun         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

FROM debian:buster

ENV AUTOINDEX on

RUN apt-get update && apt-get install -y \
    nginx \
    mariadb-server \
    php7.3 \
    php-mysql \
    php-fpm \
    php-pdo \
    php-gd \
    php-cli \
    php-mbstring \
    php-xml \
    wget

COPY srcs/nginx/nginx.conf /etc/nginx/

COPY srcs/nginx/server.conf /etc/nginx/sites-available/default
COPY srcs/nginx/server.conf /etc/nginx/sites-available/default-ssl.conf

RUN wget https://files.phpmyadmin.net/phpMyAdmin/5.1.0/phpMyAdmin-5.1.0-english.tar.gz && \
    tar -xzvf phpMyAdmin-5.1.0-english.tar.gz && \
    mv phpMyAdmin-5.1.0-english/ /var/www/html/phpmyadmin && \
    rm -rf phpMyAdmin-5.1.0-english.tar.gz
COPY srcs/phpmyadmin/config.inc.php /var/www/html/phpmyadmin

RUN wget https://wordpress.org/wordpress-5.7.1.tar.gz && \
    tar -xzvf wordpress-5.7.1.tar.gz && \
    mv wordpress /var/www/html/ && \
    rm -rf wordpress-5.7.1.tar.gz
COPY srcs/wordpress/wp-config.php /var/www/html/wordpress/wp-config-sample.php

# https://linoxide.com/mkcert-localhost-ssl-certificates-linux/
# https://computingforgeeks.com/how-to-create-locally-trusted-ssl-certificates-on-linux-and-macos-with-mkcert/
RUN mkdir ~/mkcert && cd ~/mkcert && \
	wget https://github.com/FiloSottile/mkcert/releases/download/v1.4.3/mkcert-v1.4.3-linux-amd64 && \
	mv mkcert-v1.4.3-linux-amd64 mkcert && chmod +x mkcert && \
	./mkcert -install && ./mkcert localhost


RUN	chown -R www-data:www-data /var/www/html/*
COPY srcs/*.sh ./
EXPOSE 80 443
CMD bash run.sh