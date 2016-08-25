FROM andrewgodwin/base

MAINTAINER Andrew Godwin <andrew@aeracode.org>

RUN apt-get update -qq && apt-get install -y \
    nginx

# Nginx setup
RUN mkdir -p /srv/www/
ADD index.html /srv/www/
ADD nginx.conf /etc/nginx/nginx.conf
ADD run-nginx.py /bin/
RUN chmod +x /bin/run-nginx.py
EXPOSE 80

CMD ["/bin/run-nginx.py"]
