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
    openssh-client systemd xsltproc lsb-release gnupg2 expect tmux screen ncdu p7zip-full \
    unrar screenfetch neofetch nyancat zip unzip tar cpio gzip htop coreutils bash-completion && \
    useradd -m -s /bin/bash -u 1000 ubuntu && \
    usermod -aG sudo ubuntu && \
    su ubuntu -c 'curl https://mirror.ghproxy.com/https://gist.github.com/zijianjiao2017/b7f70c36dbcc44a2668760f8384eb0b1/raw/45108c93607eb34daad892eacd88dead65cd12ca/.bash_aliases -o ~/.bash_aliases' && \
    su ubuntu -c 'curl https://mirror.ghproxy.com/https://gist.github.com/zijianjiao2017/a9e31d00eaf90950204227d99fa74c29/raw/41925374d82c86b4cf29b60c3860741eae013f28/.gitconfig -o ~/.gitconfig' && \
    su ubuntu -c 'curl https://mirror.ghproxy.com/https://gist.github.com/zijianjiao2017/1c703c8d13a8249aef2b3b6aa575d50f/raw/7396d62a63a532278222c274ba0a453019248c6f/.gitignore_global -o ~/.gitignore_global' && \
    su ubuntu -c 'git clone -b stable --single-branch --depth=1 https://mirrors4.bfsu.edu.cn/git/git-repo ~/git-repo' && \
    su ubuntu -c 'mkdir -p ~/bin/auto-ssh-agent' && \
    su ubuntu -c 'curl https://mirror.ghproxy.com/https://gist.github.com/zijianjiao2017/e7cea52fd4b9d2d3c2e183fe83b240ea/raw/f672bcd13baf9c712d6d73d568ed819a331f9d0f/add-ssh-privkey -o ~/bin/auto-ssh-agent/add-ssh-privkey' && \
    su ubuntu -c 'curl https://mirror.ghproxy.com/https://gist.github.com/zijianjiao2017/a3edae819abbe8a55fd0070a7900fe88/raw/9c25683db91ef2d12b8c4ea9dbad4621a7f0544e/ensure-ssh-agent -o ~/bin/auto-ssh-agent/ensure-ssh-agent' && \
    su ubuntu -c 'chmod +x ~/bin/auto-ssh-agent/add-ssh-privkey' && \
    su ubuntu -c 'mkdir -p ~/.ssh' && \
    su ubuntu -c 'chmod 700 ~/.ssh' && \
    su ubuntu -c 'curl https://mirror.ghproxy.com/https://gist.github.com/zijianjiao2017/bb3e704cf9538db4e50139e7b7dbbe49/raw/a6d2d71c28649ba33ce26c7853c3487a6fcd9735/id_rsa.pub -o ~/.ssh/id_rsa.pub' && \
    su ubuntu -c 'chmod 644 ~/.ssh/id_rsa.pub' && \
    su ubuntu -c 'curl https://mirror.ghproxy.com/https://gist.github.com/zijianjiao2017/1d1ba498bd9d070098452a9964b1807d/raw/0c6382693cad32377700572cc6a23fbdb3c53f57/public_key.pub -o ~/public_key.pub' && \
    su ubuntu -c 'gpg2 --import ~/public_key.pub' && \
    su ubuntu -c 'rm -f ~/public_key.pub' && \
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
