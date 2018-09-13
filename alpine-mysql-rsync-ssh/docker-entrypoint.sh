#!/bin/sh
set -e

if [ "$1" = '/usr/sbin/sshd' ]; then
  ssh-keygen -A

  if [ ! -d "/root/.ssh" ] && [ ! -s "/root/.ssh/id_rsa" ]; then
    echo "generating root ssh key..."

    mkdir /root/.ssh
    chmod 0600 /root/.ssh
    ssh-keygen -t rsa -f /root/.ssh/id_rsa -q -N ""
  fi

  if [ ! -z "$KEY" ]; then
    echo "found authorized key in env, adding..."
    echo -n $KEY >> /root/.ssh/authorized_keys
  fi
fi

exec "$@"
