FROM ubuntu:16.04
ENV UBUNTU_RELEASE_NAME=xenial

RUN echo "deb mirror://mirrors.ubuntu.com/mirrors.txt $UBUNTU_RELEASE_NAME main restricted universe multiverse\n$(cat /etc/apt/sources.list)" > /etc/apt/sources.list
RUN echo "deb mirror://mirrors.ubuntu.com/mirrors.txt $UBUNTU_RELEASE_NAME-updates main restricted universe multiverse\n$(cat /etc/apt/sources.list)" > /etc/apt/sources.list
RUN echo "deb mirror://mirrors.ubuntu.com/mirrors.txt $UBUNTU_RELEASE_NAME-backports main restricted universe multiverse\n$(cat /etc/apt/sources.list)" > /etc/apt/sources.list
RUN echo "deb mirror://mirrors.ubuntu.com/mirrors.txt $UBUNTU_RELEASE_NAME-security main restricted universe multiverse\n$(cat /etc/apt/sources.list)" > /etc/apt/sources.list
RUN cat /etc/apt/sources.list

ENTRYPOINT ["/bin/bash"]

# Dependencies
RUN apt -y update
RUN apt -y upgrade
RUN apt -y install build-essential cmake gdb git iputils-ping nano perl python valgrind wget
RUN apt -y install mesa-common-dev libgl1-mesa-dev libglu1-mesa-dev freeglut3-dev
RUN apt -y install zlib1g-dev libssl-dev libnss3-dev libmysqlclient-dev libsqlite3-dev libxslt-dev libxml2-dev libjpeg-dev libpng-dev libopus-dev
RUN apt -y install libxcursor-dev libxcb1-dev libxcb-xkb-dev libx11-xcb-dev libxrender-dev libxi-dev libxcb-xinerama0-dev
RUN apt -y install libicu-dev
RUN apt -y autoremove
RUN apt -y autoclean

# QT
WORKDIR /opt
RUN wget -q http://download.qt.io/official_releases/qt/5.9/5.9.0/single/qt-everywhere-opensource-src-5.9.0.tar.xz
RUN tar xf qt-everywhere-opensource-src-5.9.0.tar.xz
RUN rm qt-everywhere-opensource-src-5.9.0.tar.xz
WORKDIR /opt/qt-everywhere-opensource-src-5.9.0
RUN ./configure -opensource -confirm-license -release -static -nomake tests -nomake examples -no-compile-examples
RUN make -j $(($(grep -c ^processor /proc/cpuinfo 2>/dev/null || 1)+2))
RUN make install
RUN cd /opt && rm -rf qt-everywhere-opensource-src-5.9.0

ENV PATH="${PATH}:/usr/local/Qt-5.9.0/bin"
