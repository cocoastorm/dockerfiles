FROM alpine:3.5

ARG XTRABACKUP_VER=2.3.8

RUN NB_CORES=${BUILD_CORES-`getconf _NPROCESSORS_CONF`} \
  && BUILD_DEPS=" \
    automake \
    autoconf \
    binutils \
    bison \
    build-base \
    boost-dev \
    cmake \
    gcc \
    g++ \
    git \
    tar \
    wget \
    vim \
    xz \
    curl-dev \
    cppunit-dev \
    libtool \
    libgcrypt-dev \
    libaio-dev \
    libev-dev \
    libressl-dev \
    libc-dev \
    linux-headers \
    musl-dev \
    mysql-client \
    ncurses-dev \
    zlib-dev" \
  && apk -U upgrade && apk add \
    ${BUILD_DEPS} \
    bash \
    ca-certificates \
    curl \
    libaio \
    libressl \
    zlib \
    ncurses

RUN cd /tmp && mkdir xtrabackup \
    && wget -qO- https://github.com/khoanguyen96/percona-xtrabackup/archive/hotfix.tar.gz | tar zxv --strip 1 \
    && cmake -DBUILD_CONFIG=xtrabackup_release -DWITH_MAN_PAGES=off && make -j ${NB_CORES} && make install \
    && chmod -R +x /usr/local/xtrabackup/bin && ln -s /usr/local/xtrabackup/bin/* /usr/bin \
    && apk del ${BUILD_DEPS} \
    && rm -rf /var/cache/apk/* /tmp/*