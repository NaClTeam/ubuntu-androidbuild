FROM ubuntu:20.04
MAINTAINER ImFatF1sh <zijianjiao2017@gmail.com>

ENV container=docker LANG=C.UTF-8

# Enable all repositories
RUN sed -i 's/# deb/deb/g' /etc/apt/sources.list

RUN export DEBIAN_FRONTEND=noninteractive && \
    export LC_ALL=C && \
    apt-get update && \
    apt-get install --no-install-recommends --no-install-suggests -y \
    dbus systemd systemd-cron rsyslog iproute2 python python-apt sudo bash ca-certificates && \
    apt-get clean && \
    rm -rf /usr/share/doc/* /usr/share/man/* /var/lib/apt/lists/* /tmp/* /var/tmp/*

RUN sed -i 's/^\(module(load="imklog")\)/#\1/' /etc/rsyslog.conf

# Don't start any optional services except for the few we need.
RUN find /etc/systemd/system \
    /lib/systemd/system \
    -path '*.wants/*' \
    -not -name '*dbus*' \
    -not -name '*journald*' \
    -not -name '*systemd-tmpfiles*' \
    -not -name '*systemd-user-sessions*' \
    -exec rm \{} \;

RUN systemctl set-default multi-user.target
RUN systemctl mask dev-hugepages.mount sys-fs-fuse-connections.mount

STOPSIGNAL SIGRTMIN+3

CMD ["/sbin/init", "--log-target=journal"]
