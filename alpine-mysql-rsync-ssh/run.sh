#!/bin/sh

# set or create the data directory
if [ ! -z "$DATA" ]; then
  if [ ! -d "$DATA" ]; then
    mkdir -p $DATA
  fi
else
  DATA="$PWD/data"

  if [ ! -d "$DATA" ]; then
    mkdir -p "$DATA"
  fi
fi

# set authorized key
[ -z "$KEY" ] && KEY=`cat ~/.ssh/id_rsa.pub`

# set PORT to 2222 if not set
[ -z "$PORT" ] && PORT=2222

# start ssh-rsync container
docker run \
  --rm \
  -d \
  -e "KEY=$KEY" \
  -p "$PORT:22" \
  -v "$DATA:/var/data" \
  khoanguyent/alpine-rsync-ssh`
