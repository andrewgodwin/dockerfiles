www-ssl-letsencrypt
===================

Version of my ``www-ssl`` container which automatically makes certificates
using the Let's Encrypt CA and the ACME protocol.

All you need to do is set the ``DOMAIN`` and your administrator ``EMAIL``
(used for renewal warnings) using an environment variable, and
then link in the resource you want it to serve as the ``backend`` alias
(the target container must serve on port 80)::

    image: andrewgodwin/www-ssl-letsencrypt
    environment:
        DOMAIN: www.aeracode.org
        EMAIL: andrew@aeracode.org
    links:
        - aeracode-varnish:backend
    ports:
        - 80:80
        - 443:443

The domain must resolve to point at the container on ports 80 and 443;
the SSL container will complete the ACME challenge automatically and install
the certificates, and auto-renew the certs every week to make sure
they're kept up to date.

HTTP traffic will just be forwarded through to the backend unaffected.
