#!/bin/sh

# Generate Encryption Key for innobackupex, if none is found
if [ ! -f /backups/mysql/encryption_key ]; then
  printf '%s' "$(openssl rand -base64 24)" | tee /backups/mysql/encryption_key && echo
fi