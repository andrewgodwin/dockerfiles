get_iplayer
===========

Container that runs get_iplayer to download shows via its PVR feature.

You should set the environment variable PVRDIR to the place that it should
save files, and then 0 or more variables starting with ``search`` that specify
PVR searches (PVRDIR defaults to /srv/pvr if you don't provide it).

The PVR directory should be mounted as a volume; the container will also use it
to store the get_iplayer cache/state.

You can supply entries by passing environment variables to the
container where the name start with ``job`` and the value is the crontab line::

    environment:
        PVRDIR: /srv/pvr/
        searchgbbo: Great British Bake Off
