FROM httpd:2.4

# These are self-generated certs not meant for any real use!
COPY server.crt /usr/local/apache2/conf/server.crt
COPY server.key /usr/local/apache2/conf/server.key

EXPOSE 443

RUN sed -i 's%#\(Include conf/extra/httpd-ssl.conf\)%\1%' conf/httpd.conf \
  && sed -i 's%#\(LoadModule ssl_module modules/mod_ssl.so\)%\1%' conf/httpd.conf \
  && sed -i 's%#\(LoadModule socache_shmcb_module modules/mod_socache_shmcb.so\)%\1%' conf/httpd.conf \
  && sed -i 's%#\(LoadModule rewrite_module modules/mod_rewrite.so\)%\1%' conf/httpd.conf \
  && sed -i 's%#\(LoadModule proxy_module modules/mod_proxy.so\)%\1%' conf/httpd.conf \
  && sed -i 's%#\(LoadModule proxy_fcgi_module modules/mod_proxy_fcgi.so\)%\1%' conf/httpd.conf \
  && sed -i "s|#ServerName www.example.com:80|ServerName ${SERVER_NAME}:80|" conf/httpd.conf \
  && sed -i "s|DirectoryIndex index.html|DirectoryIndex index.html index.php|" conf/httpd.conf \
  && sed -i "1s|^|RewriteEngine On\nRewriteCond %{SERVER_PORT} 80\nRewriteRule ^(.*)$ https://%{SERVER_NAME}/$1 [R=301,L]\n\n|" conf/extra/httpd-ssl.conf \
  && sed -i "1s|^|ProxyPassMatch ^/(.*\.php(/.*)?)$ fcgi://dp-php:9000/var/www/html/$1\n\n|" conf/extra/httpd-ssl.conf \
  && sed -i 's%ServerName www.example.com:443%ServerName ${SERVER_NAME}:443%' conf/extra/httpd-ssl.conf 