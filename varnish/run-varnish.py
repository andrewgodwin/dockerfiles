#!/usr/bin/python3

import os

# Write any extra no-cache paths
with open("/etc/varnish/extra-recv.vcl", "w") as fh:
    if os.environ.get("NOCACHE_PATHS"):
        fh.write('if (req.url ~ "%s") {return (pipe);}\n' % os.environ["NOCACHE_PATHS"])

# Launch varnish
backend = os.environ.get("BACKEND_TYPE", "default")
os.execvp("varnishd", ["varnishd", "-a", "0.0.0.0:80", "-F", "-f", "/etc/varnish/%s.vcl" % backend])
