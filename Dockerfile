FROM rikudousage/qt-static-base:20.04

ENTRYPOINT ["/bin/bash"]

# Qt
WORKDIR /opt
RUN wget -q https://download.qt.io/official_releases/qt/6.0/6.0.0/single/qt-everywhere-src-6.0.0.tar.xz && \
    tar xf qt-everywhere-src-6.0.0.tar.xz && \
    rm qt-everywhere-src-6.0.0.tar.xz
WORKDIR /opt/qt-everywhere-src-6.0.0
RUN ./configure -opensource -confirm-license -release -static -nomake tests -nomake examples -no-compile-examples -no-icu -xcb -xcb-xlib -bundled-xcb-xinput && \
    make -j $(($(grep -c ^processor /proc/cpuinfo 2>/dev/null || 1)+2)) && \
    make install
RUN cd /opt && rm -rf qt-everywhere-src-6.0.0

WORKDIR /

# Path
ENV PATH="${PATH}:/usr/local/Qt-6.0.0/bin"
