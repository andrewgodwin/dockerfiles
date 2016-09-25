FROM andrewgodwin/base

MAINTAINER Andrew Godwin <andrew@aeracode.org>

RUN apt-get update -qq && apt-get install -y \
    postgresql-client \
    git \
    python3-pip \
    rsync \
    openssh-client

RUN pip3 install git+https://github.com/andrewgodwin/arcdiscvist@505d3feb

CMD ["sleep infinity"]
