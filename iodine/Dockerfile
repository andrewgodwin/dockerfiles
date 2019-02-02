FROM ubuntu:bionic-20181204

# Install iodine
RUN apt-get update && apt-get install -y \
    net-tools \
    iodine && \
    apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Expose the DNS port, remember to run -p 53:53/udp
EXPOSE 53/udp

ADD run-iodined /usr/local/bin/run-iodined
RUN chmod 755 /usr/local/bin/run-iodined

CMD ["/usr/local/bin/run-iodined"]
