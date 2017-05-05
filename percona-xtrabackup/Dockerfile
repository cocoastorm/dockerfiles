FROM alpine:3.5

LABEL maintainer="Khoa Nguyen <khoa.tan.nguyen.96@gmail.com"
LABEL description="Percona XtraBackup with Custom Bash Scripts"

ARG XTRABACKUP_VER=2.3.8

# Append /usr/local/bin to PATH
ENV PATH /usr/local/bin:$PATH

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
    gzip \
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
    libgcc \
    libstdc++ \
    libressl \
    ncurses \
    openssl \
    zlib \

    # Figure out Number of CPU Cores
    && NB_CORES=${BUILD_CORES-`getconf _NPROCESSORS_CONF`} \

    # Compile and Install QPress
    && mkdir -p /tmp/qpress && cd /tmp/qpress \
    && wget -qO- https://git.cocoastorm.com/khoa/qpress/archive/1.0.tar.gz | tar xz --strip 1 \
    && make -j ${NB_CORES} \
    && mv qpress /usr/bin \
    
    # Compile and Install Percona XtraBackup
    && mkdir -p /tmp/xtrabackup && cd /tmp/xtrabackup \
    && wget -qO- https://github.com/khoanguyen96/percona-xtrabackup/archive/hotfix.tar.gz | tar xz --strip 1 \
    && cmake -DBUILD_CONFIG=xtrabackup_release -DWITH_MAN_PAGES=off && make -j ${NB_CORES} && make install \

    # Copy over compiled binaries
    && cp -r /usr/local/xtrabackup/bin /usr/bin \
    && chmod -R +x /usr/bin \

    # Generate Key
    && mkdir -p /backups/mysql \
    && touch /backups/mysql/encryption_key \
    && printf '%s' "$(openssl rand -base64 24)" >> /backups/mysql/encryption_key \

    # Clean Up
    && apk del ${BUILD_DEPS} \
    && rm -rf /var/cache/apk/* /tmp/* /usr/local/xtrabackup

# Copy Backup Scripts
COPY scripts/* /usr/local/bin/
RUN chmod +x -R /usr/local/bin

VOLUME /backups/mysql /etc/mysql
WORKDIR /backups/mysql
SHELL ["/bin/bash", "-c"]