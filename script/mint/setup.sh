#!/bin/bash
set -e

echo "🚀 Bắt đầu cài đặt môi trường phát triển..."

# Update hệ thống
sudo apt update && sudo apt upgrade -y

# Gỡ phần mềm không cần thiết
echo "🧹 Gỡ bloatware..."
sudo apt purge -y hexchat thunderbird rhythmbox simple-scan libreoffice* || true
sudo apt autoremove -y

# Gọi các phần phụ
source ./install_zsh.sh
source ./install_languages.sh
source ./install_gui_apt.sh
source ./install_gui_snap.sh
source ./install_rust_tools.sh

echo "✅ Thiết lập hoàn tất!"
