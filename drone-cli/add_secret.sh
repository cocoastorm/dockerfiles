#!/bin/bash

function addSecret {
  docker run --rm \
  -e DRONE_SERVER=<SERVER_URL> \
  -e DRONE_TOKEN=<DRONE_TOKEN> \
  khoanguyent/drone-cli \
  drone secret add --repository $1 --name $2 --value $3
}

# addSecret "REPOSITORY" "COMPOSER_KEY" $COMPOSER_KEY
