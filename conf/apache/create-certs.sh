#!/bin/bash

# credits to: https://gist.github.com/xenogenesi/1b2137f769aa80b6c99d573071f5d086

# get domain info into .env file
SSL_DOMAIN=$(grep SSL_DOMAIN .env | cut -c12-)
SSL_COUNTRY=$(grep SSL_COUNTRY .env | cut -c13-)
SSL_STATE=$(grep SSL_STATE .env | cut -c11-)
SSL_COMPANY=$(grep SSL_COMPANY .env | cut -c13-)

# TODO: create log with data of certification
# printf "APP HOSTNAME: $SSL_DOMAIN \n"

# support container for creating certificates
docker run -d --name httpd-create-certs\
 --hostname ${SSL_DOMAIN}\
 -e SSL_DOMAIN=SSL_DOMAIN\
 -e SSL_COUNTRY=SSL_COUNTRY\
 -e SSL_STATE=SSL_STATE\
 -e SSL_COMPANY=SSL_COMPANY\
 httpd:2.4

# install dependencies for creating ssl in the support container
docker exec -it httpd-create-certs bash -c "apt update -y && apt -y install make git openssl && git clone https://gist.github.com/f0ab5157a45da892e110acfa4983e484.git certs"

# create ssl certificates
docker exec -it httpd-create-certs bash -c "cd certs && make DOMAIN=$SSL_DOMAIN COUNTRY=$SSL_COUNTRY STATE=$SSL_STATE COMPANY=$SSL_COMPANY"

# copies the certificates to the project (host)
docker cp httpd-create-certs:/usr/local/apache2/certs/rootCA.crt conf/apache
docker cp httpd-create-certs:/usr/local/apache2/certs/$SSL_DOMAIN.crt conf/apache/server.crt
docker cp httpd-create-certs:/usr/local/apache2/certs/$SSL_DOMAIN.key conf/apache/server.key

# TODO: check the certificate data with the rootCA key

# excludes support container
docker stop httpd-create-certs && docker rm httpd-create-certs

# removes the local support variables
unset SSL_DOMAIN && unset SSL_COUNTRY && unset SSL_STATE && unset SSL_COMPANY