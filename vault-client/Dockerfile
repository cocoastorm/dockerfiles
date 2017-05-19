FROM alpine:3.5
LABEL maintainer = "Khoa Nguyen <khoa.tan.nguyen.96@gmail.com"

ARG VAULT_VER=0.7.2

RUN NB_CORES=${BUILD_CORES-`getconf _NPROCESSORS_CONF`} \
 && BUILD_DEPS=" \
    unzip \
    wget" \
 && apk -U upgrade && apk add \
    ${BUILD_DEPS} \
    ca-certificates \
&& cd /tmp \
&& wget https://releases.hashicorp.com/vault/${VAULT_VER}/vault_${VAULT_VER}_linux_amd64.zip \
&& unzip vault_${VAULT_VER}_linux_amd64.zip \
&& cp vault /usr/bin/vault \
&& chmod +x /usr/bin/vault \
&& apk del ${BUILD_DEPS} \
&& rm -rf /var/cache/apk/* /tmp/*