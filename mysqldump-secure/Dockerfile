FROM khoanguyent/mysql-client

ARG MYSQLDUMP_SECURE_VER=0.16.3

LABEL description="mysqldump-secure" \
      maintainer="Khoa Nguyen <khoa.tan.nguyen.96@gmail.com>"

# Build Dependencies
# Install mysqldump-secure
RUN apk add --no-cache \
  build-base \
  ca-certificates \
  coreutils \
  openssl \
  gzip \
  zlib \
  && cd /tmp \
  && curl -L https://github.com/cytopia/mysqldump-secure/archive/${MYSQLDUMP_SECURE_VER}.tar.gz | tar xvzf - \
  && cd mysqldump-secure-${MYSQLDUMP_SECURE_VER} && ./configure \
  && make && make install \
  && apk del build-base \
  && rm -rf /tmp/*

ENTRYPOINT [ "mysqldump-secure" ]
