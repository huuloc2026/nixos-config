#!/bin/bash

echo "🖥️ Cài phần mềm GUI (.deb/.apt)..."

# VS Code
if ! command -v code >/dev/null; then
    wget -qO /tmp/code.deb "https://code.visualstudio.com/sha/download?build=stable&os=linux-deb-x64"
    sudo apt install -y /tmp/code.deb
fi

# DBeaver
if ! command -v dbeaver >/dev/null; then
    wget https://dbeaver.io/files/dbeaver-ce_latest_amd64.deb -O /tmp/dbeaver.deb
    sudo apt install -y /tmp/dbeaver.deb
fi

# MongoDB Compass
if ! command -v mongodb-compass >/dev/null; then
    wget https://downloads.mongodb.com/compass/mongodb-compass_1.40.4_amd64.deb -O /tmp/mongodb-compass.deb
    sudo apt install -y /tmp/mongodb-compass.deb
fi
