www-router
==========

Nginx frontend for routing requests to different Docker containers by hostname,
entirely configurable via environment variables and links (intended to be used
as part of something like docker-compose).

Does not (yet?) include SSL termination; use another container for that.


Configuration
-------------

Pass in environment variables representing the hostnames of the site, and
set the value to be the alias of the link that serves it - e.g.::

    environment:
        aerastudios.com: aerastu
        www.aerastudios.com: aerastu
        aeracode.org: aeracode
    links:
        - aeracode-varnish:aeracode
        - aerastu-varnish:aerastu

The container will only pick up environment variables with dots in them as
domains; if you wish to configure a plain hostname, leave a dot at the end::

    environment:
        mewtwo.: backend
    links:
        - bw-monitor:backend

You can set up a domain to redirect to another (for example, to make the www
version of a domain canonical)::

    environment:
        aerastudios.com: redirect:www.aerastudios.com
        www.aerastudios.com: aerastu
    links:
        - aerastu-varnish:aerastu
