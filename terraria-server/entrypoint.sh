#!/bin/sh

${SERVER_ROOT}/TerrariaServer.bin.x86_64 -config server.conf | tee /var/log/terraria/$(data +"%m_%d_%Y").log
