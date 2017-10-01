FROM php:7.1.9-apache

ENV HTTP_PROXY=nginx

ARG PHP_EXT_LIST=" \
  mysqli \
  ctype \
  dom \
  json \
  xml \
  mbstring \
  posix \
  xmlwriter \
  zip \
  pdo_sqlite \
  pdo_pgsql \
  pdo_mysql \
  pcntl \
  curl \
  fileinfo \
  bz2 \
  intl \
  simplexml \
  pgsql \
  ftp \
  exif \
  gmp"

ARG CUSTOM_BUILD_PKGS="\
  apache2-dev \
  libcurl4-openssl-dev \
  libfreetype6-dev \
  libjpeg62-turbo-dev \
  libmcrypt-dev \
  libpng12-dev \
  libicu-dev \
  libpng-dev \
  libwebp-dev \
  libgd-dev \
  libxpm-dev \
  libedit-dev \
  libxml2-dev \
  libbz2-dev \
  libpq-dev \
  zlib1g-dev \
  libsqlite3-dev \
  libgmp-dev"

RUN apt-get update && apt-get install -yqq \
    git \
    unzip \
    wget \
    zlibc \
    zlib1g \
    ${CUSTOM_BUILD_PKGS} \

# Reverse Proxy / Load Balancer (?)
&& { \
    echo '<IfModule mod_setenvif.c>'; \
    echo 'SetEnvIf X-Forwarded-Proto "^https$" AND X-Forwarded-Ssl "^on$" HTTPS=on'; \
    echo '</IfModule>'; \
  } | tee "$APACHE_CONFDIR/conf-available/reverseproxy.conf" \
  && a2enconf reverseproxy \

# Write remoteip.conf
&& { \
    echo '<IfModule mod_remoteip.c>'; \
    echo '  RemoteIPHeader X-Real-IP'; \
    echo '  RemoteIPInternalProxy 127.0.0.1'; \
    echo '</IfModule>'; \
   } | tee "$APACHE_CONFDIR/conf-available/remoteip.conf" \
   && a2enconf remoteip \

# Load mod_remoteip & mod_rewrite
&& a2enmod remoteip \
&& a2enmod rewrite \

# Install PHP Extensions
# See ARG PHP_EXT_LIST
&& docker-php-ext-install -j$(nproc) ${PHP_EXT_LIST} \

# Install Composer
&& curl --silent --show-error https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer \

# Clean Up
&& apt-get remove --purge -yqq ${CUSTOM_BUILD_PKGS} \
&& apt-get clean \
&& rm -rf /var/lib/apt/lists/*

# Copy Entrypoint Script
COPY run.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/run.sh
ENTRYPOINT ["run.sh"]

EXPOSE 80
CMD ["apache2-foreground"]