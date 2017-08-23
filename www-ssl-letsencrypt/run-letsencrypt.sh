#!/bin/bash

set -e

TRIES=0

while :
do
    # Run client to get cert
    certbot certonly --keep-until-expiring --webroot -w /srv/www/ --agree-tos -m $EMAIL -d $DOMAIN
    # If no cert appeared, try in a tighter loop
    if [ ! -f /etc/letsencrypt/live/$DOMAIN/fullchain.pem ]; then
        TRIES=$((TRIES + 1))
        if (( TRIES > 5 )); then
            echo "Failed to get cert five times, exiting."
            exit 1
        else
            echo "Failed to get cert, waiting 30s"
            sleep 30
        fi
    fi
    TRIES=0
    # Copy keys/cert into right place
    cp /etc/letsencrypt/live/$DOMAIN/fullchain.pem /etc/ssl/www.crt
    cp /etc/letsencrypt/live/$DOMAIN/privkey.pem /etc/ssl/www.key
    nginx -s reload
    echo "Certs installed, nginx reloaded."
    # Wait around a week
    sleep 6000000
done
