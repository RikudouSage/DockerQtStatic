FROM rikudousage/qt-static-base:16.04

ENTRYPOINT ["/bin/bash"]

# Qt
WORKDIR /opt
RUN wget -q https://download.qt.io/official_releases/qt/5.9/5.9.0/single/qt-everywhere-opensource-src-5.9.0.tar.xz && \
    tar xf qt-everywhere-opensource-src-5.9.0.tar.xz && \
    rm qt-everywhere-opensource-src-5.9.0.tar.xz
WORKDIR /opt/qt-everywhere-opensource-src-5.9.0
RUN ./configure -opensource -confirm-license -release -static -nomake tests -nomake examples -no-compile-examples -no-icu -qt-xcb && \
    make -j $(($(grep -c ^processor /proc/cpuinfo 2>/dev/null || 1)+2)) && \
    make install
RUN cd /opt && rm -rf qt-everywhere-opensource-src-5.9.0

WORKDIR /

# Path
ENV PATH="${PATH}:/usr/local/Qt-5.9.0/bin"
