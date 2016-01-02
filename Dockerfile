FROM phusion/baseimage:0.9.18
ENV DEBIAN_FRONTEND="noninteractive" HOME="/root" TERM="xterm" 
RUN useradd -u 911 -U -d /config -s /bin/false abc && usermod -G users abc && mkdir -p /app /config /defaults
COPY build.list* /etc/apt/sources.list
RUN apt-get update && apt-get upgrade -y -o Dpkg::Options::="--force-confold" && apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
RUN apt-get update && apt-get install -y python3-bs4 && apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
COPY *.sh /etc/my_init.d/
COPY apt-select /app/appselect 
RUN chmod +x /etc/my_init.d/*.sh
CMD ["/sbin/my_init"]

