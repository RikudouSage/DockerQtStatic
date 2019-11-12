FROM rikudousage/qt-static-base:16.04

ENTRYPOINT ["/bin/bash"]

# Qt
WORKDIR /opt
RUN wget -q https://download.qt.io/official_releases/qt/5.12/5.12.1/single/qt-everywhere-src-5.12.1.tar.xz && \
    tar xf qt-everywhere-src-5.12.1.tar.xz && \
    rm qt-everywhere-src-5.12.1.tar.xz
WORKDIR /opt/qt-everywhere-src-5.12.1
RUN ./configure -opensource -confirm-license -release -static -nomake tests -nomake examples -no-compile-examples -no-icu -qt-xcb && \
    make -j $(($(grep -c ^processor /proc/cpuinfo 2>/dev/null || 1)+2)) && \
    make install
RUN cd /opt && rm -rf qt-everywhere-src-5.12.1

WORKDIR /

# Path
ENV PATH="${PATH}:/usr/local/Qt-5.12.1/bin"
