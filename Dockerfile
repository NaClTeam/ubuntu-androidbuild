FROM ubuntu:20.04
MAINTAINER ImFatF1sh <zijianjiao2017@gmail.com>
ENV container=docker LANG=C.UTF-8
RUN export DEBIAN_FRONTEND=noninteractive && \
    export LC_ALL=C && \
    mv /etc/apt/sources.list /etc/apt/sources.list.bak && \
    echo 'deb http://mirrors.bfsu.edu.cn/ubuntu/ focal main restricted universe multiverse' > /etc/apt/sources.list && \
    echo 'deb-src http://mirrors.bfsu.edu.cn/ubuntu/ focal main restricted universe multiverse' >> /etc/apt/sources.list && \
    echo 'deb http://mirrors.bfsu.edu.cn/ubuntu/ focal-updates main restricted universe multiverse' >> /etc/apt/sources.list && \
    echo 'deb-src http://mirrors.bfsu.edu.cn/ubuntu/ focal-updates main restricted universe multiverse' >> /etc/apt/sources.list && \
    echo 'deb http://mirrors.bfsu.edu.cn/ubuntu/ focal-backports main restricted universe multiverse' >> /etc/apt/sources.list && \
    echo 'deb-src http://mirrors.bfsu.edu.cn/ubuntu/ focal-backports main restricted universe multiverse' >> /etc/apt/sources.list && \
    echo 'deb http://mirrors.bfsu.edu.cn/ubuntu/ focal-security main restricted universe multiverse' >> /etc/apt/sources.list && \
    echo 'deb-src http://mirrors.bfsu.edu.cn/ubuntu/ focal-security main restricted universe multiverse' >> /etc/apt/sources.list && \
    echo '# deb http://mirrors.bfsu.edu.cn/ubuntu/ focal-proposed main restricted universe multiverse' >> /etc/apt/sources.list && \
    echo '# deb-src http://mirrors.bfsu.edu.cn/ubuntu/ focal-proposed main restricted universe multiverse' >> /etc/apt/sources.list && \
    apt-get update && \
    apt-get install -y --no-install-recommends --no-install-suggests apt-utils && \
    apt-get install -y --no-install-recommends --no-install-suggests ca-certificates apt-transport-https && \
    sed -i 's/http:\/\//https:\/\//g' /etc/apt/sources.list && \
    apt-get update && \
    apt-get upgrade -y --no-install-recommends --no-install-suggests && \
    yes | unminimize && \
    apt-get install --no-install-recommends --no-install-suggests -y \
    libsdl1.2-dev iproute2 dialog imagemagick python x11proto-core-dev ccache \
    libxml2-utils gcc-multilib curl libx11-dev unzip libxml2 liblz4-tool libgl1-mesa-dev \
    rsync build-essential gperf g++-multilib systemd-cron dbus libncurses5-dev gnupg \
    squashfs-tools sudo fontconfig openjdk-8-jdk rsyslog zlib1g-dev wget git libssl-dev \
    libncurses5 lib32z1-dev zip git-core bash vim libc6-dev-i386 python-apt pngcrush lzop \
    schedtool bc lib32ncurses5-dev libwxgtk3.0-gtk3-dev flex nano bison lib32readline-dev \
    openssh-client systemd xsltproc lsb-release && \
    useradd -m -s /bin/bash -u 1000 ubuntu && \
    usermod -aG sudo ubuntu && \
    su ubuntu -c 'curl https://mirror.ghproxy.com/https://gist.github.com/zijianjiao2017/b7f70c36dbcc44a2668760f8384eb0b1/raw/e57970f059cbe2c28c5ba4917c89b46e9c89fe48/.bash_aliases -o ~/.bash_aliases' && \
    su ubuntu -c 'curl https://mirror.ghproxy.com/https://gist.github.com/zijianjiao2017/a9e31d00eaf90950204227d99fa74c29/raw/7aa01d03d22400cca1fd1fe9413cafbabdc0fb85/.gitconfig -o ~/.gitconfig' && \
    su ubuntu -c 'curl https://mirror.ghproxy.com/https://gist.github.com/zijianjiao2017/1c703c8d13a8249aef2b3b6aa575d50f/raw/7396d62a63a532278222c274ba0a453019248c6f/.gitignore_global -o ~/.gitignore_global' && \
    su ubuntu -c 'git clone -b stable --single-branch --depth=1 https://mirrors4.bfsu.edu.cn/git/git-repo ~/git-repo' && \
    apt-get autopurge -y && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* && \
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
    systemctl mask dev-hugepages.mount sys-fs-fuse-connections.mount
STOPSIGNAL SIGRTMIN+3
CMD ["/sbin/init", "--log-target=journal"]
