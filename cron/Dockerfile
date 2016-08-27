FROM andrewgodwin/base

MAINTAINER Andrew Godwin <andrew@aeracode.org>

RUN apt-get update -qq && apt-get install -y busybox-static wget postgresql-client

ADD generate-jobs.py /usr/bin/generate-jobs.py
RUN chmod +x /usr/bin/generate-jobs.py
RUN mkdir -p /var/spool/cron/crontabs

CMD ["generate-jobs.py && busybox crond -f -l 0 -L /dev/stdout"]
