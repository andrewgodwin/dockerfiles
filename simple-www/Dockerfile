FROM andrewgodwin/base

MAINTAINER Andrew Godwin <andrew@aeracode.org>

RUN apt-get update -qq && apt-get install -y nginx

# Nginx setup
ADD nginx.conf /etc/nginx/nginx.conf
EXPOSE 80

CMD ["nginx"]
