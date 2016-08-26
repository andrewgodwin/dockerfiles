FROM ubuntu:16.04

MAINTAINER Andrew Godwin <andrew@aeracode.org>

# Deb setup
ENV DEBIAN_FRONTEND noninteractive

# SSH configuration to never prompt to confirm host keys
ADD ssh_config /etc/ssh/ssh_config

# dpkg configuration to always keep old config files
RUN echo "force-confold\nforce-confdef" > /etc/dpkg/dpkg.cfg.d/forces

# Make sure python 3 is around
RUN apt-get update -qq && apt-get install -y \
    python3

# Install the new init script
ADD ag-init /sbin/ag-init
RUN chmod +x /sbin/ag-init; rm -r /etc/rc.*
ENTRYPOINT ["/sbin/ag-init"]

# Make a normal user for priv separation
RUN adduser --disabled-password --quiet --gecos "User" user
