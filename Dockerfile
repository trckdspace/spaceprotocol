FROM ubuntu:latest

ENV TZ=Asia/Dubai
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

RUN apt update 
RUN apt install build-essential \
    libtool \
    autotools-dev \
    automake \
    pkg-config \
    bsdmainutils \
    python3 \
    libssl-dev \
    libevent-dev \
    libboost-system-dev \
    libboost-filesystem-dev \
    libboost-chrono-dev \
    libboost-test-dev \
    libboost-thread-dev \
    libminiupnpc-dev \
    libzmq3-dev \
    libqt5gui5 \
    libqt5core5a \
    libqt5dbus5 \
    qttools5-dev \
    qttools5-dev-tools \
    libprotobuf-dev \
    protobuf-compiler \
    git \
    libsqlite3-dev \
    ccache -y

RUN git clone https://github.com/trckdspace/spaceprotocol --branch spaceprotocol --single-branch

RUN (cd spaceprotocol && ./autogen.sh && \
    ./configure --disable-tests \
    --disable-bench --disable-static  \
    --without-gui --disable-zmq \ 
    --with-incompatible-bdb \
    CFLAGS='-w' CXXFLAGS='-w' && \
    make -j 4 && \
    strip src/bitcoind && \
    strip src/bitcoin-cli && \
    strip src/bitcoin-tx && \
    make install )