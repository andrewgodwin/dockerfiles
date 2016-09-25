#!/usr/bin/python3

import os
import sys
from jinja2 import Template

name = os.environ.get("name", "NAME")
workgroup = os.environ.get("workgroup", "WORKGROUP")
description = os.environ.get("description", "Samba Server")
shares = []

for key, value in os.environ.items():
    if key.startswith("share"):
        bits = value.split("|")
        shares.append({
            "name": bits[0],
            "path": bits[1],
        })

with open("/etc/samba/smb.conf.jinja", "r") as fh:
    template_string = fh.read()

with open("/etc/samba/smb.conf", "w") as fh:
    fh.write(Template(template_string).render(
        name=name,
        workgroup=workgroup,
        description=description,
        shares=shares,
    ))

print("Initialisation finished.")
