FROM php:5.6-apache
RUN apt-get update
RUN apt-get install -y libpng12-dev curl libcurl4-gnutls-dev libxml2-dev libldb-dev libldap2-dev libc-client-dev libkrb5-dev && apt-get clean
RUN ln -s /usr/lib/x86_64-linux-gnu/libldap.so /usr/lib/libldap.so && ln -s /usr/lib/x86_64-linux-gnu/liblber.so /usr/lib/liblber.so
RUN docker-php-ext-install mysqli
RUN docker-php-ext-install gd
RUN docker-php-ext-install xmlrpc
RUN docker-php-ext-install curl
RUN docker-php-ext-install opcache
RUN docker-php-ext-install ldap
RUN docker-php-ext-configure imap --with-kerberos --with-imap-ssl
RUN docker-php-ext-install imap
ADD php.ini /usr/local/etc/php

