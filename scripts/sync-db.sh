#!/usr/bin/env bash

# NOTES:
# - https://www.tweaking4all.com/forum/macos-x-software/waking-up-a-mac-with-wake-on-lan/

SOURCE_REMOTE_HOST=
SOURCE_SLEEP=
SOURCE_USER=

print_usage() {
  echo ""
  echo "Usage:"
  echo "  -h remote host"
  echo "  -s time in seconds to sleep, allowing file to sync"
  echo "  -u remote username"
}

while getopts 'h:s:u:' flag; do
  case "${flag}" in
    h) SOURCE_REMOTE_HOST="${OPTARG}" ;;
    s) SOURCE_SLEEP="${OPTARG}" ;;
    u) SOURCE_USER="${OPTARG}" ;;
    *) print_usage
       exit 1 ;;
  esac
done

SOURCE_PATH="/Users/${SOURCE_USER}/Library/Group\ Containers/JLMPQHK86H.com.culturedcode.ThingsMac/Things\ Database.thingsdatabase/main.sqlite"

# Wake up remote host
if [ ! -z $SOURCE_REMOTE_HOST ]; then
  ssh ${SOURCE_USER}@${SOURCE_REMOTE_HOST} "caffeinate -u -t 1"
fi

# Wait for Things database file to sync
if [[ $SOURCE_SLEEP -gt 0 ]]; then
  sleep $SOURCE_SLEEP
fi

# Sync Things database file
if [ ! -z $SOURCE_REMOTE_HOST ]; then
  rsync -avz ${SOURCE_USER}@${SOURCE_REMOTE_HOST}:"${SOURCE_PATH}" ./db/main.sqlite3
else
  cp ${SOURCE_PATH} ./db/main.sqlite3
fi
