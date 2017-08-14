FROM alpine:3.6

ARG LIGHTTPD_VER=1.4.45
ARG PHP_VER=7.1.8
ARG LIBICONV_VER=1.15
ARG H5AI_VER=0.29.0

ARG PHP_MIRROR=http://ch1.php.net

ARG BUILD_CORES

LABEL description="lighttpd + php and h5ai" \
      maintainer="Khoa Nguyen <khoa.tan.nguyen.96@gmail.com"

COPY rootfs /

COPY html /var/www/html

ARG LIGHTTPD_CONF="\
    --prefix=/lighttpd \
    --exec-prefix=/lighttpd \
    --bindir=/usr/bin \
    --sbindir=/usr/local/sbin \
    --sysconfdir=/etc \
    --datadir=/usr/share \
    --includedir=/usr/include \
    --libdir=/usr/lib \
    --libexecdir=/usr/libexec \
    --localstatedir=/var \
    --sharedstatedir=/usr/com \
    --with-openssl \
    --with-pcre \
    --with-zlib \
    --with-bzip2 \
    --with-PACKAGE=mod_redirect \
    --with-rewrite \
    --with-redirect \
    --with-ssi"

ARG PHP_CONF=" \
    --prefix=/usr \
    --libdir=/usr/lib/php \
    --datadir=/usr/share/php \
    --sysconfdir=/php/etc \
    --localstatedir=/php/var \
    --with-pear=/usr/share/php \
    --with-config-file-scan-dir=/php/conf.d \
    --with-config-file-path=/php \
    --with-pic \
    --disable-short-tags \
    --without-readline \
    --enable-bcmath=shared \
    --enable-fpm \
    --disable-cgi \
    --enable-mysqlnd \
    --enable-mbstring \
    --with-curl \
    --with-libedit \
    --with-openssl \
    --with-iconv=/usr/local \
    --with-gd \
    --with-jpeg-dir \
    --with-png-dir \
    --with-webp-dir \
    --with-xpm-dir=no \
    --with-freetype-dir \
    --enable-gd-native-ttf \
    --disable-gd-jis-conv \
    --with-zlib"

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
    zlib \
    pdo_sqlite \
    pdo_pgsql \
    pdo_mysql \
    pcntl \
    curl \
    fileinfo \
    bz2 \
    mcrypt \
    ldap \
    simplexml \
    pgsql \
    ftp \
    exif \
    gmp"

ARG CUSTOM_BUILD_PKGS=" \
    freetype-dev \
    openldap-dev \
    gmp-dev \
    libmcrypt-dev \
    libpng-dev \
    libwebp-dev \
    gd-dev \
    libjpeg-turbo-dev \
    libxpm-dev \
    libedit-dev \
    libxml2-dev \
    libressl-dev \
    libbz2 \
    mariadb-dev \
    sqlite-dev \
    postgresql-dev"

ARG CUSTOM_PKGS=" \
    freetype \
    openldap \
    gmp \
    libmcrypt \
    bzip2-dev \
    libpq"

RUN NB_CORES=${BUILDCORES-$(getconf _NPROCESSORS_CONF)} \

# ensure www-data user exists
set -x \
  && addgroup -g 82 -S www-data \
  && adduser -u 82 -D -S -G www-data www-data \
  && chown www-data:www-data /var/www/html \
  && chown www-data:www-data /lighttpd \

### Packages Installations
  && BUILD_DEPS=" \
    linux-headers \
    libtool \
    build-base \
    pcre-dev \
    zlib-dev \
    wget \
    unzip \
    gnupg \
    autoconf \
    automake \
    gcc \
    git \
    g++ \
    libc-dev \
    make \
    pkgconf \
    curl-dev \
    ca-certificates \
    ${CUSTOM_BUILD_PKGS}" \
  && apk -U add \
    ${BUILD_DEPS} \
    s6 \
    su-exec \
    curl \
    libedit \
    libxml2 \
    libressl \
    libxml2 \
    libwebp \
    gd \
    pcre \
    perl \
    perl-mime-types \
    zlib \
    ${CUSTOM_PKGS} \

### Source Downloads

  ## lighttpd
  && LIGHTTPD_RELEASE=$(echo $LIGHTTPD_VER | sed 's/.\{2\}$//')x \
  && wget http://download.lighttpd.net/lighttpd/releases-${LIGHTTPD_RELEASE}/lighttpd-${LIGHTTPD_VER}.tar.gz -O /tmp/lighttpd-${LIGHTTPD_VER}.tar.gz \
  && wget http://download.lighttpd.net/lighttpd/releases-${LIGHTTPD_RELEASE}/lighttpd-${LIGHTTPD_VER}.tar.gz.asc -O /tmp/lighttpd-${LIGHTTPD_VER}.tar.gz.asc \

  # h5ai
  && wget https://release.larsjung.de/h5ai/h5ai-${H5AI_VER}.zip -O /tmp/h5ai-${H5AI_VER}.zip \

  ## php
  && wget ${PHP_MIRROR}/get/php-${PHP_VER}.tar.gz/from/this/mirror -O /tmp/php-${PHP_VER}.tar.gz \
  && wget ${PHP_MIRROR}/get/php-${PHP_VER}.tar.gz.asc/from/this/mirror -O /tmp/php-${PHP_VER}.tar.gz.asc \
  
  ## libiconv
  && wget http://ftp.gnu.org/pub/gnu/libiconv/libiconv-${LIBICONV_VER}.tar.gz -O /tmp/libiconv-${LIBICONV_VER}.tar.gz \
  
  ## make the directories
  && mkdir -p /php/conf.d \
  && mkdir -p /usr/src \
  
  ## extract all the things
  && unzip /tmp/h5ai-${H5AI_VER}.zip -d /var/www/html \
  && tar xzf /tmp/lighttpd-${LIGHTTPD_VER}.tar.gz -C /usr/src \
  && tar xzf /tmp/php-${PHP_VER}.tar.gz -C /usr/src \
  && tar xzf /tmp/libiconv-${LIBICONV_VER}.tar.gz -C /usr/src \

  ### GNU Libiconv installation
  && cd /usr/src/libiconv-${LIBICONV_VER} \
  && ./configure --prefix=/usr/local \
  && make && make install && libtool --finish /usr/local/lib \

  ### lighttpd Installation
  && cd /usr/src/lighttpd-${LIGHTTPD_VER} \
  && ./configure CFLAGS="-O3 -fstack-protector-strong" ${LIGHTTPD_CONF} \
  && make -j ${NB_CORES} \
  && make install \

  ### PHP installation
  && mv /usr/src/php-${PHP_VER} /usr/src/php \
  && cd /usr/src/php \
  && ./configure CFLAGS="-O3 -fstack-protector-strong" ${PHP_CONF} \
  && make -j ${NB_CORES} \
  && make install \

  ### strip, clean, install modules
  && { find /usr/local/bin /usr/local/sbin -type f -perm +0111 -exec strip --strip-all '{}' + || true; } \
  && make clean \
  && chmod +x /usr/local/bin/* /etc/s6.d/*/* /etc/s6.d/.s6-svscan/* \
  && docker-php-ext-install ${PHP_EXT_LIST} \
  && apk del ${BUILD_DEPS} \
  && rm -rf /tmp/* /var/cache/apk/* /usr/src/* \
  && mkdir -p /lighttpd/run /lighttpd/logs /var/cache/lighttpd/uploads /var/cache/lighttpd/compress /var/www/html /php/php-fpm.d /php/logs /php/run /php/session

EXPOSE 8000 44300
VOLUME /var/www/html
CMD ["run.sh"]
