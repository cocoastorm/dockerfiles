#!/bin/sh
set -e

# copy h5ai
unzip /opt/h5ai-${H5AI_VER}.zip -d /var/www/html

# set uid/gid in lighttpd.conf
# sed -i -e '/server.username =/ s/= .*/= $UID/' /lighttpd/lighttpd.conf
# sed -i -e '/server.groupname =/ s/= .*/= $GID' /lighttpd/lighttpd.conf

# set permissions for most files
chown -R ${UID}:${GID} /etc/s6.d /lighttpd /php /var/www/html

# set permissions for mime.types and *.pl files
chown ${UID}:${GID} /etc/mime.types
chmod +x /lighttpd/*.pl

# run the things with s6
exec su-exec ${UID}:${GID} /bin/s6-svscan /etc/s6.d
