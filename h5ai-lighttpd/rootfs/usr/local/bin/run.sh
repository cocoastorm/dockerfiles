#!/bin/sh
set -e

# set permissions for most files
chown -R www-data:www-data /etc/s6.d /lighttpd /php /var/www/html

# set permissions for mime.types and *.pl files
chown www-data:www-data /etc/mime.types
chmod +x /lighttpd/*.pl

# run the things with s6
exec su-exec www-data:www-data /bin/s6-svscan /etc/s6.d
