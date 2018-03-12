FROM alpine:3.7
LABEL maintainer="Khoa Nguyen <khoa.tan.nguyen.96@gmail.com"

ARG DRONE_CLI_VER=0.8.3

RUN apk --update --no-cache add --virtual build-dependencies \
  tar \
  wget \
  zlib \
  && cd /tmp \
  && wget -qO- https://github.com/drone/drone-cli/releases/download/v${DRONE_CLI_VER}/drone_linux_amd64.tar.gz | tar zx \
  && install -t /usr/local/bin drone \
  && apk del build-dependencies
