FROM andrewgodwin/base

MAINTAINER Andrew Godwin <andrew@aeracode.org>

RUN apt-get update -qq && apt-get install -y varnish

# Nginx setup
ADD *.vcl /etc/varnish/
ADD run-varnish.py /usr/local/bin/run-varnish
RUN chmod +x /usr/local/bin/run-varnish

EXPOSE 80

CMD ["/usr/local/bin/run-varnish"]
