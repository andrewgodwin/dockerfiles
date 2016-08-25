www-ssl
=======

SSL termination container for HTTP. Listens for SSL on port 443,
forwards it to the container linked as alias ``backend`` on port 80.

You'll need to either volume-mount the certificate chain to
``/etc/ssl/www.crt`` and the key to ``/etc/ssl/www.key``, or inherit from
this container and ``ADD`` them.
