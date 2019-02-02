iodine-docker
=============

Docker image for `Iodine <http://code.kryo.se/iodine/>`. Based on work by ``wingrunr21`` and ``FiloSottile``.

Usage
-----

::

    docker pull andrewgodwin/iodine
    docker run -d --privileged -p 53:53/udp -e IODINE_HOST=t.example.com -e IODINE_PASSWORD=1234password andrewgodwin/iodine

Environment Variables
---------------------

* ``IODINE_HOST`` - the domain where your iodine server is running
* ``IODINE_PASSWORD`` - the password for your iodine server
* ``IODINE_TUNNEL_IP`` - the server tunnel ip. Optional and defaults to 10.0.0.1.
