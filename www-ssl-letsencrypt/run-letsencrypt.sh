#!/bin/bash

# Wait for DH params to be generated
while ! [ -f /etc/ssl/dhparams.pem ];
do
    sleep 1
done
echo "DH params present, starting cert negotiation"
sleep 1

while :
do
    # Run client to get cert
    certbot certonly --keep-until-expiring --webroot -w /srv/www/ --agree-tos -m $EMAIL -d $DOMAIN
    # If no cert appeared, fail hard.
    if [ ! -f /etc/letsencrypt/live/$DOMAIN/fullchain.pem ]; then
        echo "Failed to get cert, exiting"
        exit 1
    fi
    # Copy keys/cert into right place
    cp /etc/letsencrypt/live/$DOMAIN/fullchain.pem /etc/ssl/www.crt
    cp /etc/letsencrypt/live/$DOMAIN/privkey.pem /etc/ssl/www.key
    nginx -s reload
    echo "Certs installed, nginx reloaded."
    # Wait around a week
    sleep 6000000
done
