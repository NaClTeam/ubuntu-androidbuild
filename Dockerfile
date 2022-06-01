FROM ubuntu:focal
MAINTAINER Ookiineko <chiisaineko@protonmail.com>
ENV container docker
ENV LC_ALL C
ENV LANG C.UTF-8
ENV NO_RPOXY localhost,127.0.0.0/8,::1
ENV HTTP_PROXY http://10.0.0.144:23666/
ENV HTTPS_PROXY http://10.0.0.144:23666/
ENV RSYNC_PROXY http://10.0.0.144:23666/
ENV FTP_PROXY http://10.0.0.144:23666/
ENV no_proxy localhost,127.0.0.0/8,::1
ENV http_proxy http://10.0.0.144:23666/
ENV https_proxy http://10.0.0.144:23666/
ENV rsync_proxy http://10.0.0.144:23666/
ENV ftp_proxy http://10.0.0.144:23666/
SHELL ["/bin/bash", "-c"]
RUN export DEBIAN_FRONTEND=noninteractive && \
    export LC_ALL=C && \
    echo 'deb http://mirrors4.tuna.tsinghua.edu.cn/ubuntu/ focal main restricted universe multiverse' > /etc/apt/sources.list && \
    echo 'deb http://mirrors4.tuna.tsinghua.edu.cn/ubuntu/ focal-updates main restricted universe multiverse' >> /etc/apt/sources.list && \
    echo 'deb http://mirrors4.tuna.tsinghua.edu.cn/ubuntu/ focal-backports main restricted universe multiverse' >> /etc/apt/sources.list && \
    echo 'deb http://mirrors4.tuna.tsinghua.edu.cn/ubuntu/ focal-security main restricted universe multiverse' >> /etc/apt/sources.list && \
    echo "Acquire::http::proxy \"http://10.0.0.144:23666/\";" > /etc/apt/apt.conf.d/95proxies && \
    echo "Acquire::https::proxy \"http://10.0.0.144:23666/\";" >> /etc/apt/apt.conf.d/95proxies && \
    echo "Acquire::ftp::proxy \"http://10.0.0.144:23666/\";" >> /etc/apt/apt.conf.d/95proxies && \
    echo "Acquire::socks::proxy \"http://10.0.0.144:23666/\";" >> /etc/apt/apt.conf.d/95proxies && \
    apt-get update && \
    apt-get install -y --no-install-recommends --no-install-suggests apt-utils && \
    apt-get install -y --no-install-recommends --no-install-suggests ca-certificates apt-transport-https && \
    sed -i 's/http:\/\//https:\/\//g' /etc/apt/sources.list && \
    apt-get update && \
    apt-get install -y --no-install-recommends --no-install-suggests software-properties-common && \
    add-apt-repository -y ppa:git-core/ppa && \
    apt-get upgrade -y --no-install-recommends --no-install-suggests && \
    yes | unminimize && \
    apt-get install --no-install-recommends --no-install-suggests -y \
    libsdl1.2-dev iproute2 dialog imagemagick python x11proto-core-dev ccache netcat \
    libxml2-utils gcc-multilib curl libx11-dev unzip libxml2 liblz4-tool libgl1-mesa-dev \
    rsync build-essential gperf g++-multilib systemd-cron dbus libncurses5-dev gnupg \
    squashfs-tools sudo fontconfig openjdk-8-jdk rsyslog zlib1g-dev wget git libssl-dev \
    libncurses5 lib32z1-dev zip git-core bash vim libc6-dev-i386 python-apt pngcrush lzop \
    schedtool bc lib32ncurses5-dev libwxgtk3.0-gtk3-dev flex nano bison lib32readline-dev \
    openssh-client systemd xsltproc lsb-release gnupg2 expect tmux ncdu p7zip-full unrar \
    neofetch tar cpio gzip htop coreutils iputils-ping bash-completion net-tools passwd \
    command-not-found less man-db clang zlib1g-dev file gdebi aria2 bind9-dnsutils locales && \
    useradd -m -s /bin/bash -u 1000 ubuntu && \
    usermod -aG adm,cdrom,sudo,dip,plugdev ubuntu && \
    update-locale && \
    su ubuntu -c 'curl https://gist.githubusercontent.com/ookiineko/787bb6f21bdaacf00f315b3f5f48997e/raw/0d97c1ddc59f572f446e419dcde22e7ada8d8834/.bash_aliases -o ~/.bash_aliases' && \
    su ubuntu -c 'curl https://gist.githubusercontent.com/ookiineko/4c68614abc640e7aaf39c563b3912d81/raw/5cf90020cf876e0ad10eaed572665d7ca483e995/.gitconfig -o ~/.gitconfig' && \
    su ubuntu -c 'curl https://gist.githubusercontent.com/ookiineko/523258de221a3af4d58e2d81e27a6236/raw/1ea267bfbf3b5f095991251b99f4643969fda7c3/.gitignore_global -o ~/.gitignore_global' && \
    su ubuntu -c 'mkdir -p ~/.bin' && \
    su ubuntu -c 'curl https://storage.googleapis.com/git-repo-downloads/repo -o ~/.bin/repo && chmod a+x ~/.bin/repo' && \
    su ubuntu -c 'curl https://gist.githubusercontent.com/ookiineko/51cf2d15aeff0cc491d0ac1edd3c8793/raw/fbc516689f1dae5978d78609df17a8b59ca3224a/ensure-ssh-agent -o ~/.bin/ensure-ssh-agent' && \
    su ubuntu -c 'mkdir -p ~/.ssh' && \
    su ubuntu -c 'chmod 700 ~/.ssh' && \
    su ubuntu -c 'curl https://gist.githubusercontent.com/ookiineko/97395a5f77e491f2b2b7fbc8290529c1/raw/63f089827f1a4e3c75f6c1b533b18f3cd97668ed/id_rsa.pub -o ~/.ssh/id_rsa.pub' && \
    su ubuntu -c 'curl https://gist.githubusercontent.com/ookiineko/bd5114c8530f30911aa6a64cac75f249/raw/898584bdc0f407582a869ea68c7b04a731da52e7/config -o ~/.ssh/config' && \
    su ubuntu -c 'chmod 644 ~/.ssh/id_rsa.pub' && \
    su ubuntu -c 'chmod 700 ~/.ssh/config' && \
    ln -s /mnt/workspace /workspace && \
    ln -s /mnt/workspace /home/ubuntu/Workspace && \
    rm -f /etc/apt/apt.conf.d/docker-gzip-indexes && \
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
    systemctl mask dev-hugepages.mount sys-fs-fuse-connections.mount && \
    echo 'container=docker' >> /etc/environment && echo 'LC_ALL=C' >> /etc/environment && \
    echo 'LANG="C.UTF-8"' >> /etc/environment && echo 'NO_RPOXY="localhost,127.0.0.0/8,::1"' >> /etc/environment && \
    echo 'HTTP_PROXY="http://10.0.0.144:23666/"' >> /etc/environment && \
    echo 'HTTPS_PROXY="http://10.0.0.144:23666/"' >> /etc/environment && \
    echo 'RSYNC_PROXY="http://10.0.0.144:23666/"' >> /etc/environment && \
    echo 'FTP_PROXY="http://10.0.0.144:23666/"' >> /etc/environment && \
    echo 'no_proxy="localhost,127.0.0.0/8,::1"' >> /etc/environment && \
    echo 'http_proxy="http://10.0.0.144:23666/"' >> /etc/environment && \
    echo 'https_proxy="http://10.0.0.144:23666/"' >> /etc/environment && \
    echo 'rsync_proxy="http://10.0.0.144:23666/"' >> /etc/environment && \
    echo 'ftp_proxy="http://10.0.0.144:23666/"' >> /etc/environment && \
    echo 'ALLOW_MISSING_DEPENDENCIES=true' >> /etc/environment && \
    echo 'CCACHE_DIR="/mnt/workspace/Containers/ubuntu-androidbuild/Caches/CCACHE_HOME"' >> /etc/environment && \
    echo 'USE_CCACHE=1' >> /etc/environment && echo 'JAVA_TOOL_OPTIONS="-Xmx16G"' >> /etc/environment && \
    echo '_JAVA_OPTIONS="-Xmx16G"' >> /etc/environment && \
    source /etc/environment && \
    ccache -M 30G
STOPSIGNAL SIGRTMIN+3
CMD ["/sbin/init", "--log-target=journal"]
