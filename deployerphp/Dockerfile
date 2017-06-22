FROM php:alpine
LABEL maintainer="Khoa Nguyen <khoa.tan.nguyen.96@gmail.com"

ARG DEPLOYER_VER=v5.1.0
ENV DEPLOYER_CHECKSUM=716b08c01837048406bf45f4a7870d58d028bf55

# Install SSH Client and CA Certificates
RUN apk add --no-cache ca-certificates openssh-client

# Download and Install Deployer from deployer.org
RUN curl --silent --show-error --location --output /usr/bin/dep https://deployer.org/releases/${DEPLOYER_VER}/deployer.phar \
  && echo "${DEPLOYER_CHECKSUM}  /usr/bin/dep" | sha1sum -c - \
  && chmod +x /usr/bin/dep
