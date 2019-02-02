FROM andrewgodwin/base

MAINTAINER Andrew Godwin <andrew@aeracode.org>

# Get basic system dependencies
RUN apt-get update -qq && apt-get install -y \
    nginx \
    git \
    python \
    python-dev \
    python-pip \
    gcc \
    dialog \
    libaugeas0 \
    libssl-dev \
    libffi-dev \
    ca-certificates \
    software-properties-common

# Install the certbot client
RUN add-apt-repository ppa:certbot/certbot && \
    apt-get update -qq && \
    apt-get install -y certbot

# Set up nginx
ADD nginx.conf /etc/nginx/nginx.conf
EXPOSE 443

# Make sure the challenge directory is present
RUN mkdir /srv/www/

# Install self-signed certs to power things until a real one happens
ADD temporary-cert.crt /etc/ssl/www.crt
ADD temporary-cert.key /etc/ssl/www.key
ADD dhparams.pem /etc/ssl/dhparams.pem

# Install update script
ADD run-letsencrypt.sh /bin/run-letsencrypt
RUN chmod 775 /bin/run-letsencrypt

# Run both nginx and the looping script to update the certs
CMD [ \
    "nginx", \
    "/bin/run-letsencrypt" \
]
