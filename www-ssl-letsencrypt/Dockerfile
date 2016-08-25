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

# Get letsencrypt client
RUN git clone https://github.com/letsencrypt/letsencrypt.git /opt/letsencrypt

# Install the client and a newer version of six
RUN pip install -U \
    six \
    -e /opt/letsencrypt/acme \
    -e /opt/letsencrypt/

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
    "nginx", \
    "/bin/run-letsencrypt" \
]
