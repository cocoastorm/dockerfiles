FROM php:cli
LABEL maintainer="Khoa Nguyen <khoa.tan.nguyen.96@gmail.com"

ARG DEPLOYER_VER=v5.0.0

# Install SSH Client and CA Certificates
RUN apt-get update && apt-get install -y \
  ca-certificates \
  ssh \
&& rm -rf /var/lib/apt/lists/*

# Download and Install Deployer from deployer.org
RUN curl --silent --show-error --location --output /usr/local/bin/dep https://deployer.org/releases/${DEPLOYER_VER}/deployer.phar \
  && chmod +x /usr/local/bin/dep

ENTRYPOINT ["dep"]
CMD ['deploy']