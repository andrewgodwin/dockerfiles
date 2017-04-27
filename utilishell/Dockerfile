FROM andrewgodwin/base

MAINTAINER Andrew Godwin <andrew@aeracode.org>

RUN apt-get update -qq && apt-get install -y \
    postgresql-client \
    git \
    python3-pip \
    rsync \
    openssh-client \
    vim-full \
    nano \
    software-properties-common

RUN apt-add-repository ppa:brandonsnider/cdrtools && apt-get update -qq && apt-get install -y \
    cdrecord \
    udftools \
    par2 \
    eject

RUN pip3 install git+https://github.com/andrewgodwin/arcdiscvist@b33d518

CMD ["sleep infinity"]
