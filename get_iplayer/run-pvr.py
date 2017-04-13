#!/usr/bin/python3

import os
import sys
import time
import datetime
import subprocess

print("Booting PVR script")
sys.stdout.flush()

# Get target
binary = "/srv/get_iplayer/get_iplayer"
target = os.environ.get("PVRDIR", "/srv/pvr")
profile_dir = os.path.join(target, "profile")
profile_pvr_dir = os.path.join(profile_dir, "pvr")

# Get searches
searches = {}
for key, value in os.environ.items():
    if key.startswith("search"):
        searches[key[6:]] = value

# Remove any existing PVR searches and lock
subprocess.check_call(["rm", "-rf", profile_pvr_dir])
subprocess.check_call(["rm", "-rf", os.path.join(profile_dir, "pvr_lock")])

# Re-add searches
for name, value in sorted(searches.items()):
    print("Adding PVR search %s: %s" % (name, value), file=sys.stderr)
    sys.stderr.flush()
    subprocess.check_call([
        binary,
        "--profile-dir=%s" % profile_dir,
        "--pvr-add",
        name,
        value,
    ])

# PVR loop
while True:
    # Run PVR downloads
    print("Starting loop at %s" % datetime.datetime.utcnow(), file=sys.stdout)
    print("Running PVR download", file=sys.stdout)
    sys.stdout.flush()
    subprocess.call(["bash", "-c", "date"])
    subprocess.call([
        binary,
        "--profile-dir=%s" % profile_dir,
        "--pvr",
        "--modes=best",
        '--fileprefix=<nameshort><.senum><.episodeshort>',
        "--overwrite",
        "--expiry=3600",
        "-o", target,
    ])
    # Delete old PVR recordings
    print("Deleting old recordings", file=sys.stdout)
    sys.stdout.flush()
    subprocess.check_call([
        "find",
        target,
        "-type", "f",
        "-mtime", "+3",
        "-iname", "*.mp4",
        "-delete",
    ])
    # Sleeeeeep
    print("Sleeping for an hour", file=sys.stdout)
    sys.stdout.flush()
    time.sleep(3600)
