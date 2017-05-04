FROM alpine:3.5
LABEL maintainer="Khoa Nguyen <khoa.tan.nguyen.96@gmail.com"
ARG XTRABACKUP_VER=2.3.8

# Required Build Dependencies
ENV BUILD_DEPS=" \
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
    zlib-dev"

# Install required packages
RUN apk -U upgrade && apk add \
    ${BUILD_DEPS} \
    bash \
    ca-certificates \
    coreutils \
    curl \
    libaio \
    libressl \
    ncurses \
    openssl \
    zlib

# Compile and Install Percona XtraBackup
RUN NB_CORES=${BUILD_CORES-`getconf _NPROCESSORS_CONF`} \
    && cd /tmp && mkdir xtrabackup \
    && wget -qO- https://github.com/khoanguyen96/percona-xtrabackup/archive/hotfix.tar.gz | tar xvz --strip 1 \
    && cmake -DBUILD_CONFIG=xtrabackup_release -DWITH_MAN_PAGES=off && make -j ${NB_CORES} && make install \
    && cp -r /usr/local/xtrabackup/bin /usr/local/bin \
    && chmod -R +x /usr/bin \
    && apk del ${BUILD_DEPS} \
    && rm -rf /var/cache/apk/* /tmp/* /usr/local/xtrabackup

# Copy Backup Scripts
COPY scripts/* /usr/local/bin/
RUN chmod +x -R /usr/local/bin
ENV PATH /usr/local/bin:$PATH

# Set Up Volumes and Key
RUN mkdir -p /backups/mysql \
    && mkdir -p /etc/mysql \
    && touch /backups/mysql/encryption_key \
    && printf '%s' "$(openssl rand -base64 24)" >> /backups/mysql/encryption_key
VOLUME /backups/mysql /etc/mysql

WORKDIR /backups/mysql
SHELL ["/bin/bash", "-c"]