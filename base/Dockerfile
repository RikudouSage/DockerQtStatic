ARG VERSION
FROM ubuntu:$VERSION
ARG CODENAME

RUN echo "deb mirror://mirrors.ubuntu.com/mirrors.txt $CODENAME main restricted universe multiverse\n$(cat /etc/apt/sources.list)" > /etc/apt/sources.list
RUN echo "deb mirror://mirrors.ubuntu.com/mirrors.txt $CODENAME-updates main restricted universe multiverse\n$(cat /etc/apt/sources.list)" > /etc/apt/sources.list
RUN echo "deb mirror://mirrors.ubuntu.com/mirrors.txt $CODENAME-backports main restricted universe multiverse\n$(cat /etc/apt/sources.list)" > /etc/apt/sources.list
RUN echo "deb mirror://mirrors.ubuntu.com/mirrors.txt $CODENAME-security main restricted universe multiverse\n$(cat /etc/apt/sources.list)" > /etc/apt/sources.list

# Dependencies
RUN apt-get -y update && \
    apt-get -y upgrade && \
    apt-get -y install build-essential cmake gdb git iputils-ping nano perl python valgrind wget pkg-config && \
    apt-get -y install mesa-common-dev libgl1-mesa-dev libglu1-mesa-dev freeglut3-dev && \
    apt-get -y install zlib1g-dev libssl-dev libnss3-dev libmysqlclient-dev libsqlite3-dev libxslt-dev libxml2-dev libjpeg-dev libpng-dev libopus-dev && \
    apt-get -y install libxcursor-dev libxcb1-dev libxcb-xkb-dev libx11-xcb-dev libxrender-dev libxi-dev libxcb-xinerama0-dev && \
    apt-get -y install libfontconfig1-dev libfreetype6-dev libxkbcommon-x11-dev libxkbcommon-dev && \
    apt-get -y autoremove && \
    apt-get -y autoclean
