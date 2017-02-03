#!/bin/bash
nginx -g "daemon off;" &
pidof nginx

! [ -d /usr/share/nginx/html/$dominioservice ] && mkdir /usr/share/nginx/html/$dominioservice
! [ -d /usr/share/nginx/html/$dominioservice/.well-known ] && mkdir /usr/share/nginx/html/$dominioservice/.well-known

if ! [ -d /etc/letsencrypt/live/$dominioservice ] &&  $ssl >/dev/null 2>&1
then 
    echo "Criando chaves letsencrypt"
    sed  "s/addressservice/$addressservice/g;s/portservice/$portservice/g;s/dominioservice/$dominioservice/g" /default.init > /etc/nginx/conf.d/default.conf 
    cat /etc/nginx/conf.d/default.conf
    nginx -s reload
    certbot certonly -n --webroot --agree-tos --email $emailregister -w /usr/share/nginx/html/$dominioservice -d $dominioservice -d $dominioservice

fi
echo "Criando aquivo de final do ngnix"
if $ssl
then
    sed  "s/addressservice/$addressservice/g;s/portservice/$portservice/g;s/dominioservice/$dominioservice/g" /default.end > /etc/nginx/conf.d/default.conf 
else
    sed  "s/addressservice/$addressservice/g;s/portservice/$portservice/g;s/dominioservice/$dominioservice/g" /default.init > /etc/nginx/conf.d/default.conf 
fi
cat /etc/nginx/conf.d/default.conf
nginx -s reload
while true;
do
    if $ssl 
    then  
        echo Recriando certificado
        certbot renew --renew-hook "nginx -s reload"
    fi
    sleep 10
done
