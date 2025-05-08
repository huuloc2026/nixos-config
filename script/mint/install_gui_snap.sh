#!/bin/bash

echo "📦 Cài ứng dụng bổ sung bằng Snap..."

sudo apt install -y snapd

# Postman
if ! command -v postman >/dev/null; then
    sudo snap install postman
fi

# Telegram
if ! command -v telegram-desktop >/dev/null; then
    sudo snap install telegram-desktop
fi

# Teams
if ! command -v teams-for-linux >/dev/null; then
    sudo snap install teams-for-linux
fi
