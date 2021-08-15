FROM ubuntu:focal
MAINTAINER ImFatF1sh <imfatf1sh@protonmail.com>
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
    neofetch zip unzip tar cpio gzip htop coreutils iputils-ping bash-completion net-tools \
    apt-file command-not-found less man-db clang zlib1g-dev file gdebi aria2 bind9-dnsutils && \
    useradd -m -s /bin/bash -u 1000 ubuntu && \
    usermod -aG sudo ubuntu && \
    su ubuntu -c 'curl https://mirror.ghproxy.com/https://gist.github.com/zijianjiao2017/b7f70c36dbcc44a2668760f8384eb0b1/raw/8d633614dc17c50144e5598e1db8fbe61cc7e5db/.bash_aliases -o ~/.bash_aliases' && \
    su ubuntu -c 'curl https://mirror.ghproxy.com/https://gist.github.com/zijianjiao2017/a9e31d00eaf90950204227d99fa74c29/raw/75c4f9bed57535b01452fa572edce8b2c54ca8bb/.gitconfig -o ~/.gitconfig' && \
    su ubuntu -c 'curl https://mirror.ghproxy.com/https://gist.github.com/zijianjiao2017/1c703c8d13a8249aef2b3b6aa575d50f/raw/7396d62a63a532278222c274ba0a453019248c6f/.gitignore_global -o ~/.gitignore_global' && \
    su ubuntu -c 'git clone -b stable --single-branch --depth=1 https://mirrors4.bfsu.edu.cn/git/git-repo ~/git-repo' && \
    su ubuntu -c 'git clone -b android10 --single-branch --depth=1 https://mirror.ghproxy.com/https://github.com/LonelyFool/lpunpack_and_lpmake ~/lpunpack_and_lpmake' && \
    su ubuntu -c 'cd ~/lpunpack_and_lpmake && ./make.sh' && \
    su ubuntu -c 'mkdir -p ~/bin/auto-ssh-agent' && \
    su ubuntu -c 'curl https://mirror.ghproxy.com/https://gist.github.com/zijianjiao2017/e7cea52fd4b9d2d3c2e183fe83b240ea/raw/369611db341a921daaa50a6310d04c84020a1768/add-ssh-privkey -o ~/bin/auto-ssh-agent/add-ssh-privkey' && \
    su ubuntu -c 'curl https://mirror.ghproxy.com/https://gist.github.com/zijianjiao2017/a3edae819abbe8a55fd0070a7900fe88/raw/dafacb6e36f45431cfc0b1d0e3aa00dec4eb1490/ensure-ssh-agent -o ~/bin/auto-ssh-agent/ensure-ssh-agent' && \
    su ubuntu -c 'chmod +x ~/bin/auto-ssh-agent/add-ssh-privkey' && \
    su ubuntu -c 'mkdir -p ~/.ssh' && \
    su ubuntu -c 'chmod 700 ~/.ssh' && \
    su ubuntu -c 'curl https://mirror.ghproxy.com/https://gist.github.com/zijianjiao2017/bb3e704cf9538db4e50139e7b7dbbe49/raw/a6d2d71c28649ba33ce26c7853c3487a6fcd9735/id_rsa.pub -o ~/.ssh/id_rsa.pub' && \
    su ubuntu -c 'chmod 644 ~/.ssh/id_rsa.pub' && \
    su ubuntu -c 'curl https://mirror.ghproxy.com/https://gist.github.com/zijianjiao2017/1d1ba498bd9d070098452a9964b1807d/raw/0c6382693cad32377700572cc6a23fbdb3c53f57/public_key.pub -o ~/public_key.pub' && \
    su ubuntu -c 'gpg2 --import ~/public_key.pub' && \
    su ubuntu -c 'rm -f ~/public_key.pub' && \
    su ubuntu -c 'mkdir -p ~/.config/htop' && \
    su ubuntu -c 'curl https://mirror.ghproxy.com/https://gist.github.com/zijianjiao2017/f0937b1432a1e529f6d0d02e62589672/raw/8fa271d878de9f6ff6e7331f55bd4e6170104bb1/htoprc -o ~/.config/htop/htoprc' && \
    apt-get autopurge -y && \
    (dpkg -l | grep '^rc' | awk '{print $2}' | xargs apt-get -y purge) && \
    apt-get clean && \
    apt-get autoclean all -y && \
    rm -f /etc/apt/apt.conf.d/docker-gzip-indexes && \
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
