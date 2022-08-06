FROM ubuntu:focal
MAINTAINER Ookiineko <chiisaineko@protonmail.com>
ENV container docker
ENV LC_ALL C
ENV LANG C.UTF-8
SHELL ["/bin/bash", "-c"]
ADD configs /tmp/uab_i/0
ADD tools /tmp/uab_i/1
COPY customizations /tmp/uab_i/2
COPY late_customizations /tmp/uab_i/3
COPY build_proxies /tmp/uab_i/4
RUN export DEBIAN_FRONTEND=noninteractive && \
    source /tmp/uab_i/2 && \
    source /tmp/uab_i/4 && \
    echo "deb http://${UAB_APT_M}/ubuntu/ focal main restricted universe multiverse" > /etc/apt/sources.list && \
    echo "deb http://${UAB_APT_M}/ubuntu/ focal-updates main restricted universe multiverse" >> /etc/apt/sources.list && \
    echo "deb http://${UAB_APT_M}/ubuntu/ focal-backports main restricted universe multiverse" >> /etc/apt/sources.list && \
    echo "deb http://${UAB_APT_SEC_M}/ubuntu/ focal-security main restricted universe multiverse" >> /etc/apt/sources.list && \
    apt-get update && \
    apt-get install -y --no-install-recommends --no-install-suggests apt-utils && \
    apt-get install -y --no-install-recommends --no-install-suggests ca-certificates apt-transport-https && \
    sed -i 's/http:\/\//https:\/\//g' /etc/apt/sources.list && \
    apt-get update && \
    apt-get install -y --no-install-recommends --no-install-suggests software-properties-common && \
    add-apt-repository -y ppa:git-core/ppa && \
    apt-get upgrade -y --no-install-recommends --no-install-suggests && \
    yes | unminimize && \
    i=0 && \
    while [ $i -eq 0 ]; do \
    apt-get --fix-missing install --no-install-recommends --no-install-suggests -y \
    libsdl1.2-dev iproute2 dialog imagemagick python x11proto-core-dev ccache netcat \
    libxml2-utils gcc-multilib curl libx11-dev unzip libxml2 liblz4-tool libgl1-mesa-dev \
    rsync build-essential gperf g++-multilib systemd-cron dbus libncurses5-dev gnupg psmisc \
    squashfs-tools sudo fontconfig openjdk-8-jdk rsyslog zlib1g-dev wget git libssl-dev \
    libncurses5 lib32z1-dev zip git-core bash vim libc6-dev-i386 python-apt pngcrush lzop \
    schedtool bc lib32ncurses5-dev libwxgtk3.0-gtk3-dev flex nano bison lib32readline-dev \
    openssh-client systemd xsltproc lsb-release gnupg2 expect tmux ncdu p7zip-full unrar \
    neofetch tar cpio gzip htop coreutils iputils-ping bash-completion net-tools passwd \
    command-not-found less man-db clang zlib1g-dev file gdebi aria2 bind9-dnsutils locales \
    device-tree-compiler kmod rename findutils genisoimage tmate; \
    [[ "$?" -eq 0 ]] && i=1; done && \
    sed -i /etc/java-8-openjdk/security/java.security -re 's/^jdk.tls.disabledAlgorithms=.*/jdk.tls.disabledAlgorithms=SSLv3, RC4, DES, MD5withRSA, \\/g' && \
    useradd -m -s /bin/bash -u 1000 ubuntu && \
    usermod -aG adm,cdrom,sudo,dip,plugdev ubuntu && \
    sed -i /etc/sudoers -re 's/^%sudo.*/%sudo ALL=(ALL:ALL) NOPASSWD: ALL/g' && \
    update-locale && \
    chown ubuntu:ubuntu -R /tmp/uab_i && \
    chmod 775 -R /tmp/uab_i && \
    su ubuntu -pc 'bash /tmp/uab_i/0/inst_cfgs' && \
    su ubuntu -pc 'bash /tmp/uab_i/1/inst_tools' && \
    ln -s /mnt/workspace /workspace && \
    ln -s /mnt/workspace /home/ubuntu/Workspace && \
    rm -f /etc/apt/apt.conf.d/docker-gzip-indexes && \
    apt-get autopurge -y && \
    apt-get clean && \
    sed -i 's/^\(module(load="imklog")\)/#\1/' /etc/rsyslog.conf && \
    find /etc/systemd/system \
    /lib/systemd/system \
    -path '*.wants/*' \
    -not -name '*dbus*' \
    -not -name '*journald*' \
    -not -name '*systemd-tmpfiles*' \
    -not -name '*systemd-user-sessions*' \
    -exec rm \{} \; && \
    systemctl set-default multi-user.target && \
    systemctl mask dev-hugepages.mount sys-fs-fuse-connections.mount && \
    bash /tmp/uab_i/3 && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
STOPSIGNAL SIGRTMIN+3
CMD ["/sbin/init", "--log-target=journal"]
