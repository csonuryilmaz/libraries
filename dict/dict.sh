#!/bin/bash -i

set -e

if [ "$1" = "--install" ] || [ "$1" = "-i" ]; then
    DICT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
    sudo ln -s $DICT_DIR/dict.sh /usr/local/bin/dict \
    && sudo chmod +x /usr/local/bin/dict \
    && echo "[✓] Installed."
    exit 0;
fi

if [ "$1" = "--uninstall" ] || [ "$1" = "-u" ]; then
    sudo rm -rf /usr/local/bin/dict \
    && echo "[✓] Uninstalled."
    exit 0;
fi

KEYWORD=$1

if [ -z "$KEYWORD" ]; then
    echo "[e] Please enter a keyword as an argument!"
    exit 1;
fi

if [ ! -x curl ] ; then
    command -v curl >/dev/null 2>&1 || { echo >&2 "[e] Please install curl or set it in your path! \nFor debian, ubuntu and their derivative gnu/linux distributions run: \nsudo apt install curl"; exit 1; }
fi

curl dict://dict.org/d:$KEYWORD:fd-eng-tur
