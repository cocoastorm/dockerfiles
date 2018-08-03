FROM alpine:3.8

ARG BUILD_CORES

RUN NB_CORES=${BUILD_CORES-`getconf _NPROCESSORS_CONF`} \
  && BUILD_DEPS=" \
  build-base \
  binutils \
  g++" \
  && apk -U upgrade && apk add \
  ${BUILD_DEPS} \
  ca-certificates \
  coreutils \
  libgcc \
  libstdc++ \
  gzip \
  tar \
  wget \
  xz \
  && mkdir -p /tmp/qpress && cd /tmp/qpress \
  && wget -qO- https://git.cocoastorm.com/khoa/qpress/archive/1.0.tar.gz | tar xz --strip 1 \
  && make -j ${NB_CORES} \
  && mv qpress /usr/bin \
  && apk del ${BUILD_DEPS} \
  && rm -rf /var/cache/apk/* /tmp/*

CMD qpress
