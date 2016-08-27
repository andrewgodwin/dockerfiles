#!/usr/bin/python3

import os
import sys

for key, value in os.environ.items():
    if key.startswith("job"):
        # Write out file
        cron_path = "/var/spool/cron/crontabs/root"
        with open(cron_path, "a") as fh:
            fh.write(value)
        print("Wrote %s to %s: %s" % (key, cron_path, value))

print("Initialisation finished.")
