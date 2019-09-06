FROM ubuntu:18.04
ENV UBUNTU_RELEASE_NAME=bionic

RUN echo "deb mirror://mirrors.ubuntu.com/mirrors.txt $UBUNTU_RELEASE_NAME main restricted universe multiverse\n$(cat /etc/apt/sources.list)" > /etc/apt/sources.list
RUN echo "deb mirror://mirrors.ubuntu.com/mirrors.txt $UBUNTU_RELEASE_NAME-updates main restricted universe multiverse\n$(cat /etc/apt/sources.list)" > /etc/apt/sources.list
RUN echo "deb mirror://mirrors.ubuntu.com/mirrors.txt $UBUNTU_RELEASE_NAME-backports main restricted universe multiverse\n$(cat /etc/apt/sources.list)" > /etc/apt/sources.list
RUN echo "deb mirror://mirrors.ubuntu.com/mirrors.txt $UBUNTU_RELEASE_NAME-security main restricted universe multiverse\n$(cat /etc/apt/sources.list)" > /etc/apt/sources.list

ENTRYPOINT ["/bin/bash"]

# Dependencies
RUN apt-get -y update
RUN apt-get -y upgrade
RUN apt-get -y install build-essential cmake gdb git iputils-ping nano perl python valgrind wget pkg-config
RUN apt-get -y install mesa-common-dev libgl1-mesa-dev libglu1-mesa-dev freeglut3-dev
RUN apt-get -y install zlib1g-dev libssl-dev libnss3-dev libmysqlclient-dev libsqlite3-dev libxslt-dev libxml2-dev libjpeg-dev libpng-dev libopus-dev
RUN apt-get -y install libxcursor-dev libxcb1-dev libxcb-xkb-dev libx11-xcb-dev libxrender-dev libxi-dev libxcb-xinerama0-dev
RUN apt-get -y autoremove
RUN apt-get -y autoclean

# Qt
WORKDIR /opt
RUN wget -q https://download.qt.io/official_releases/qt/5.13/5.13.1/single/qt-everywhere-src-5.13.1.tar.xz
RUN tar xf qt-everywhere-src-5.13.1.tar.xz
RUN rm qt-everywhere-src-5.13.1.tar.xz
WORKDIR /opt/qt-everywhere-src-5.13.1
RUN ./configure -opensource -confirm-license -release -static -nomake tests -nomake examples -no-compile-examples -no-icu
RUN make -j $(($(grep -c ^processor /proc/cpuinfo 2>/dev/null || 1)+2))
RUN make install
RUN cd /opt && rm -rf qt-everywhere-src-5.13.1

WORKDIR /

# Path
ENV PATH="${PATH}:/usr/local/Qt-5.13.1/bin"
