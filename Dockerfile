FROM ubuntu:focal
MAINTAINER ImFatF1sh <imfatf1sh@protonmail.com>
ENV container=docker LANG=C.UTF-8
SHELL ["/bin/bash", "-c"]
RUN export DEBIAN_FRONTEND=noninteractive && \
    export LC_ALL=C && \
    mv /etc/apt/sources.list /etc/apt/sources.list.bak && \
    echo 'deb http://mirrors4.tuna.tsinghua.edu.cn/ubuntu/ focal main restricted universe multiverse' > /etc/apt/sources.list && \
    echo '# deb-src http://mirrors4.tuna.tsinghua.edu.cn/ubuntu/ focal main restricted universe multiverse' >> /etc/apt/sources.list && \
    echo 'deb http://mirrors4.tuna.tsinghua.edu.cn/ubuntu/ focal-updates main restricted universe multiverse' >> /etc/apt/sources.list && \
    echo '# deb-src http://mirrors4.tuna.tsinghua.edu.cn/ubuntu/ focal-updates main restricted universe multiverse' >> /etc/apt/sources.list && \
    echo 'deb http://mirrors4.tuna.tsinghua.edu.cn/ubuntu/ focal-backports main restricted universe multiverse' >> /etc/apt/sources.list && \
    echo '# deb-src http://mirrors4.tuna.tsinghua.edu.cn/ubuntu/ focal-backports main restricted universe multiverse' >> /etc/apt/sources.list && \
    echo 'deb http://mirrors4.tuna.tsinghua.edu.cn/ubuntu/ focal-security main restricted universe multiverse' >> /etc/apt/sources.list && \
    echo '# deb-src http://mirrors4.tuna.tsinghua.edu.cn/ubuntu/ focal-security main restricted universe multiverse' >> /etc/apt/sources.list && \
    echo '# deb http://mirrors4.tuna.tsinghua.edu.cn/ubuntu/ focal-proposed main restricted universe multiverse' >> /etc/apt/sources.list && \
    echo '# deb-src http://mirrors4.tuna.tsinghua.edu.cn/ubuntu/ focal-proposed main restricted universe multiverse' >> /etc/apt/sources.list && \
    apt-get update && \
    apt-get install -y --no-install-recommends --no-install-suggests apt-utils && \
    apt-get install -y --no-install-recommends --no-install-suggests ca-certificates apt-transport-https && \
    sed -i 's/http:\/\//https:\/\//g' /etc/apt/sources.list && \
    apt-get update && \
    apt-get install -y --no-install-recommends --no-install-suggests software-properties-common && \
    apt-get upgrade -y --no-install-recommends --no-install-suggests && \
    yes | unminimize && \
    apt-get install --no-install-recommends --no-install-suggests -y \
    libsdl1.2-dev iproute2 dialog imagemagick python x11proto-core-dev ccache \
    libxml2-utils gcc-multilib curl libx11-dev unzip libxml2 liblz4-tool libgl1-mesa-dev \
    rsync build-essential gperf g++-multilib systemd-cron dbus libncurses5-dev gnupg \
    squashfs-tools sudo fontconfig openjdk-8-jdk rsyslog zlib1g-dev wget git libssl-dev \
    libncurses5 lib32z1-dev zip git-core bash vim libc6-dev-i386 python-apt pngcrush lzop \
    schedtool bc lib32ncurses5-dev libwxgtk3.0-gtk3-dev flex nano bison lib32readline-dev \
    openssh-client systemd xsltproc lsb-release gnupg2 expect tmux ncdu p7zip-full unrar \
    neofetch tar cpio gzip htop coreutils iputils-ping bash-completion net-tools \
    command-not-found less man-db clang zlib1g-dev file gdebi aria2 bind9-dnsutils && \
    useradd -m -s /bin/bash -u 1000 ubuntu && \
    usermod -aG sudo ubuntu && \
    cp -avf /etc/environment /etc/environment.original && \
    rm -f ~/.bash_aliases ~/.gitconfig ~/.gitignore_global && \
    su ubuntu -c 'curl https://mirror.ghproxy.com/https://gist.githubusercontent.com/ookiineko/787bb6f21bdaacf00f315b3f5f48997e/raw/c2800c09fee42588d75d4952d437d9ee31f389a4/.bash_aliases -o ~/.bash_aliases' && \
    su ubuntu -c 'curl https://mirror.ghproxy.com/https://gist.githubusercontent.com/ookiineko/4c68614abc640e7aaf39c563b3912d81/raw/50c56fde831e4d7978164dfdcc47f1409fc8509d/.gitconfig -o ~/.gitconfig' && \
    su ubuntu -c 'curl https://mirror.ghproxy.com/https://gist.githubusercontent.com/ookiineko/523258de221a3af4d58e2d81e27a6236/raw/1ea267bfbf3b5f095991251b99f4643969fda7c3/.gitignore_global -o ~/.gitignore_global' && \
    su ubuntu -c 'mkdir -p ~/.bin/auto-ssh-agent' && \
    su ubuntu -c 'git clone -b stable --single-branch --depth=1 --no-tags https://mirrors4.bfsu.edu.cn/git/git-repo ~/.bin/git-repo' && \
    su ubuntu -c 'git clone -b android10 --single-branch --no-tags --depth=1 https://gitee.com/zijianjiao2017/FORK-ONLY_lpunpack_and_lpmake.git ~/.bin/lpunpack_and_lpmake' && \
    su ubuntu -c 'cd ~/.bin/lpunpack_and_lpmake && ./make.sh' && \
    su ubuntu -c 'curl https://mirror.ghproxy.com/https://gist.githubusercontent.com/ookiineko/51cf2d15aeff0cc491d0ac1edd3c8793/raw/fbc516689f1dae5978d78609df17a8b59ca3224a/ensure-ssh-agent -o ~/.bin/auto-ssh-agent/ensure-ssh-agent' && \
    su ubuntu -c 'mkdir -p ~/.ssh' && \
    su ubuntu -c 'chmod 700 ~/.ssh' && \
    su ubuntu -c 'curl https://mirror.ghproxy.com/https://gist.githubusercontent.com/ookiineko/97395a5f77e491f2b2b7fbc8290529c1/raw/63f089827f1a4e3c75f6c1b533b18f3cd97668ed/id_rsa.pub -o ~/.ssh/id_rsa.pub' && \
    su ubuntu -c 'curl https://mirror.ghproxy.com/https://gist.githubusercontent.com/ookiineko/bd5114c8530f30911aa6a64cac75f249/raw/898584bdc0f407582a869ea68c7b04a731da52e7/config -o ~/.ssh/config' && \
    su ubuntu -c 'chmod 644 ~/.ssh/id_rsa.pub' && \
    su ubuntu -c 'chmod 600 ~/.ssh/config' && \
    su ubuntu -c 'mkdir -p ~/.config/htop' && \
    su ubuntu -c 'curl https://mirror.ghproxy.com/https://gist.githubusercontent.com/ookiineko/90fd562b82814e07322d9db8a0d75499/raw/7c058a098d7b68a20f0589bad76dc6a74ea51350/htoprc -o ~/.config/htop/htoprc' && \
    ln -s /mnt/workspace /workspace && \
    ln -s /mnt/workspace /home/ubuntu/Workspace && \
    rm -f /etc/apt/apt.conf.d/docker-gzip-indexes && \
    apt-get autopurge -y && \
    (dpkg -l | grep '^rc' | awk '{print $2}' | xargs apt-get -y purge) && \
    apt-get clean && \
    apt-get autoclean all -y && \
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
