#!/usr/bin/python3

import os

# Write any extra no-cache paths
with open("/etc/varnish/extra-recv.vcl", "w") as fh:
    if os.environ.get("NOCACHE_PATHS"):
        fh.write('if (req.url ~ "%s") {return (pipe);}\n' % os.environ["NOCACHE_PATHS"])

# Write the backend VCL
with open("/etc/varnish/backend.vcl", "w") as fh:
    fh.write("vcl 4.0;\n")
    fh.write('backend default { .host = "%s"; .port = "%s"; }' % (
        os.environ.get("BACKEND_HOST", "backend"),
        os.environ.get("BACKEND_PORT", "80"),
    ))

# Launch varnish
backend = os.environ.get("BACKEND_TYPE", "default")
os.execvp("varnishd", ["varnishd", "-a", "0.0.0.0:80", "-F", "-f", "/etc/varnish/%s.vcl" % backend])
