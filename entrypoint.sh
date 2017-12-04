#!/bin/sh
set -e

if [ -z "${NETATMO_CLIENT_ID+x}" ] || [ -z "${NETATMO_CLIENT_SECRET+x}" ] || [ -z "${NETATMO_USERNAME+x}" ] || [ -z "${NETATMO_PASSWORD+x}" ] || [ -z "${NETATMO_DEVICE_ID+x}" ] ;  then
    
   echo "You must set env variables for netatmo plugin !"
   exit 1

fi


if [ "${1:0:1}" = '-' ]; then
    set -- telegraf "$@"
fi

exec "$@"
