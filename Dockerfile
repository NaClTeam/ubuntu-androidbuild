FROM ubuntu:focal
MAINTAINER ImFatF1sh <imfatf1sh@protonmail.com>
ENV container=docker LANG=C.UTF-8
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
    su ubuntu -c 'curl https://mirror.ghproxy.com/https://gist.githubusercontent.com/4zuk1/8a6dcd8b792b11039390ae4dc4b69b79/raw/41f432af899899de0ef23a7c7100c0c68413a169/.bash_aliases -o ~/.bash_aliases' && \
    su ubuntu -c 'curl https://mirror.ghproxy.com/https://gist.githubusercontent.com/4zuk1/8ff7910115b63bea25a0c162dd667065/raw/0ae8eec1380e566f4b66460d30226b558eaf7c47/.gitconfig -o ~/.gitconfig' && \
    su ubuntu -c 'curl https://mirror.ghproxy.com/https://gist.githubusercontent.com/4zuk1/7951e303e24e0b3e1b06eb5f693e22d3/raw/a74f1c3eceb4d765f258b668f914ddfce476aa44/.gitignore_global -o ~/.gitignore_global' && \
    su ubuntu -c 'mkdir -p ~/.bin/auto-ssh-agent' && \
    su ubuntu -c 'git clone -b stable --single-branch --depth=1 --no-tags https://mirrors4.bfsu.edu.cn/git/git-repo ~/.bin/git-repo' && \
    su ubuntu -c 'git clone -b android10 --single-branch --no-tags --depth=1 https://gitee.com/zijianjiao2017/FORK-ONLY_lpunpack_and_lpmake.git ~/.bin/lpunpack_and_lpmake' && \
    su ubuntu -c 'cd ~/.bin/lpunpack_and_lpmake && ./make.sh' && \
    su ubuntu -c 'curl https://mirror.ghproxy.com/https://gist.githubusercontent.com/4zuk1/1dac65056d1b693eb44f71b7fe6dde91/raw/6a50a7e99e26fc93139851c75e9c221669795590/ensure-ssh-agent -o ~/.bin/auto-ssh-agent/ensure-ssh-agent' && \
    su ubuntu -c 'mkdir -p ~/.ssh' && \
    su ubuntu -c 'chmod 700 ~/.ssh' && \
    su ubuntu -c 'curl https://mirror.ghproxy.com/https://gist.githubusercontent.com/4zuk1/a72fe3bb4352f5110931fd100cc5c943/raw/f1daecfc33410969acab35cdf216a0df05fb0071/id_rsa.pub -o ~/.ssh/id_rsa.pub' && \
    su ubuntu -c 'chmod 644 ~/.ssh/id_rsa.pub' && \
    su ubuntu -c 'curl https://mirror.ghproxy.com/https://gist.githubusercontent.com/4zuk1/e4bfbb4c7913236c5b1bf0f33d027fb1/raw/68ad0529bdddac18cc26653fb78bacf6d543cc9b/public_key.pub -o ~/public_key.pub' && \
    su ubuntu -c 'gpg2 --import ~/public_key.pub' && \
    su ubuntu -c 'rm -f ~/public_key.pub' && \
    su ubuntu -c 'mkdir -p ~/.config/htop' && \
    su ubuntu -c 'curl https://mirror.ghproxy.com/https://gist.githubusercontent.com/4zuk1/505f0f1c6aee9762d5374b478ad249ec/raw/45f0c5a9b8b25bf39ef1b4278f0329d9104c39d0/htoprc -o ~/.config/htop/htoprc' && \
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
