FROM andrewgodwin/base

MAINTAINER Andrew Godwin <andrew@aeracode.org>

RUN apt-get update -qq && apt-get install -y samba python3-jinja2

ADD smb.conf /etc/samba/smb.conf.jinja

ADD generate-config.py /usr/bin/generate-config.py
RUN chmod +x /usr/bin/generate-config.py

EXPOSE 137
EXPOSE 138
EXPOSE 139
EXPOSE 445

CMD ["generate-config.py && script --return -c 'smbd -FS' /dev/null"]
