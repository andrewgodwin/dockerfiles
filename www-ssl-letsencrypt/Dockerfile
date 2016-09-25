FROM andrewgodwin/www-ssl

MAINTAINER Andrew Godwin <andrew@aeracode.org>

# Get basic system dependencies
RUN apt-get update -qq && apt-get install -y \
    git \
    python \
    python-dev \
    python-pip \
    gcc \
    dialog \
    libaugeas0 \
    libssl-dev \
    libffi-dev \
    ca-certificates

# Install the client and a newer version of six
RUN pip install -U \
    six \
    git+https://github.com/certbot/certbot.git@v0.8.1

# Make sure the challenge directory is present
RUN mkdir /srv/www/

# Install self-signed certs to power things until a real one happens
ADD temporary-cert.crt /etc/ssl/www.crt
ADD temporary-cert.key /etc/ssl/www.key

# Install update script
ADD run-letsencrypt.sh /bin/run-letsencrypt
RUN chmod 775 /bin/run-letsencrypt

# Run both nginx and the looping script to update the certs
CMD [ \
    "openssl dhparam -out /etc/ssl/dhparams.pem 2048 && nginx", \
    "/bin/run-letsencrypt" \
]
