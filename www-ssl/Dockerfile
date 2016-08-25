FROM andrewgodwin/base

MAINTAINER Andrew Godwin <andrew@aeracode.org>

RUN apt-get update -qq && apt-get install -y \
    nginx \
    openssl

# Nginx setup
ADD nginx.conf /etc/nginx/nginx.conf
EXPOSE 443

CMD ["openssl dhparam -out /etc/ssl/dhparams.pem 2048 && nginx"]
