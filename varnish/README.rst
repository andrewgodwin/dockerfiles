docker-varnish
##############

Basic Varnish image for Docker; accepts a link called "backend"
and an optional environment variable called "BACKEND_TYPE" that
can be set to one of the more specific options for common setups:

- default
- django

It's available on `Docker Hub <https://hub.docker.com/r/andrewgodwin/varnish/>`_.

No-cache paths
--------------

Set the ``NOCACHE_PATHS`` environment variable to a regular expression matching
paths you don't want to cache.
