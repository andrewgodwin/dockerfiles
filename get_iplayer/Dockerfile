FROM andrewgodwin/base

MAINTAINER Andrew Godwin <andrew@aeracode.org>

# Install dependencies
RUN apt-get update -qq && apt-get install -y \
    ffmpeg \
    perl \
    libwww-perl \
    libxml-simple-perl \
    libxml-libxml-perl \
    atomicparsley \
    id3v2 \
    git \
    curl

# Download release
RUN cd /srv && \
    curl https://codeload.github.com/get-iplayer/get_iplayer/tar.gz/v3.01 | tar xvz && \
    mv get_iplayer-* get_iplayer

# Install binaries
ADD run-pvr.py /usr/bin/run-pvr.py
RUN chmod +x /usr/bin/run-pvr.py

CMD ["run-pvr.py"]
