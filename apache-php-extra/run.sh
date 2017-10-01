#!/bin/bash
set -e

# if $HTTP_PROXY is set, replace $HTTP_PROXY_IP with the results of getent lookup
if [ -v "$HTTP_PROXY" ] && [ -z "$HTTP_PROXY_IP" ]; then
  HTTP_PROXY_IP=$(getent hosts "$HTTP_PROXY" | awk '{ print $1 }')
fi

# if $HTTP_PROXY_IP is set, replace RemoteIPInternalProxy with it in apache remoteip.conf
if [ -v "$HTTP_PROXY_IP" ]; then
  sed -i '/RemoteIPInternalProxy/d' "$APACHE_CONFDIR/conf-available/remoteip.conf"
  echo "RemoteIPInternalProxy $HTTP_PROXY" >> "$APACHE_CONFDIR/conf-available/remoteip.conf"
fi

# first arg is `-f` or `--some-option`
if [ "${1#-}" != "$1" ]; then
	set -- apache2-foreground "$@"
fi

exec "$@"
