FROM andrewgodwin/base

# Install Shinken, Nagios plugins, nginx and supervisord
RUN apt-get update && apt-get install -y python-pip \
    python-pycurl \
    python-cherrypy3 \
    nagios-plugins \
    libsys-statistics-linux-perl \
    ntp \
    ssmtp \
    libssl-dev \
    python-crypto \
    inotify-tools && \
    apt-get -y autoremove && \
    apt-get clean

RUN useradd --create-home shinken && pip install shinken==2.4.2

# Install shinken modules
RUN su - shinken -c 'shinken --init && \
    shinken install webui && \
    shinken install auth-cfg-password && \
    shinken install sqlitedb && \
    shinken install pickle-retention-file-scheduler && \
    shinken install booster-nrpe'

# Configure Shinken modules
ADD shinken.cfg /etc/shinken/shinken.cfg
ADD broker-master.cfg /etc/shinken/brokers/broker-master.cfg
ADD poller-master.cfg /etc/shinken/pollers/poller-master.cfg
ADD scheduler-master.cfg /etc/shinken/schedulers/scheduler-master.cfg
ADD webui.cfg /etc/shinken/modules/webui.cfg
ADD sqlitedb.cfg /etc/shinken/modules/sqlitedb.cfg

# Remove example configs and make persistence dir
RUN rm -r /etc/shinken/contacts/* \
    /etc/shinken/hosts/* \
    /etc/shinken/contactgroups/* && \
    mkdir /srv/shinken && \
    chown shinken /srv/shinken

# Set up SSMTP
ADD ssmtp.conf /etc/ssmtp/ssmtp.conf

# Persistence dir
VOLUME /srv/shinken

# Expose port 8080 for webui
EXPOSE 8080

# chown directory on startup
RUN echo "#!/bin/bash\nchown shinken -R /srv/shinken\n" > /etc/rc.local && chmod +x /etc/rc.local

# Shinken has LOTS of daemons
CMD [ \
    "/usr/bin/shinken-arbiter -c /etc/shinken/shinken.cfg", \
    "/usr/bin/shinken-broker -c /etc/shinken/daemons/brokerd.ini", \
    "/usr/bin/shinken-poller -c /etc/shinken/daemons/pollerd.ini", \
    "/usr/bin/shinken-reactionner -c /etc/shinken/daemons/reactionnerd.ini", \
    "/usr/bin/shinken-receiver -c /etc/shinken/daemons/receiverd.ini", \
    "/usr/bin/shinken-scheduler -c /etc/shinken/daemons/schedulerd.ini" \
]

# You'll need to inherit from this and supply hosts/commands/etc files into
# the right /etc/shinken/ directories.
