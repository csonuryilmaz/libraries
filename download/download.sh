#!/bin/sh

set -e

URL=$1
SAVE_AS=$2

if [ -z "$URL" ]; then
    echo "[e] Please define download URL as first argument!"
    exit;
fi

if [ -z "$SAVE_AS" ]; then
    echo "[*] Auto detecting save as argument ..."
    SAVE_AS=$(curl -sI  $URL | grep -o -E 'filename=.*$' | tr -d '\r\n' | sed -e 's/filename=//')
fi
if [ -z "$SAVE_AS" ]; then
    SAVE_AS=$(curl -sI  $URL | grep -o -E 'location:.*$' | tr -d '\r\n' | rev | cut -d'/' -f1 | rev)
fi

echo "[i] Downloaded file will be saved as: $SAVE_AS"

curl -o $SAVE_AS -L $URL