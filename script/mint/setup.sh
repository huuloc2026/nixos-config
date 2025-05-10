#!/bin/bash
set -e

echo "🚀 Bắt đầu cài đặt môi trường phát triển..."

# Update hệ thống
sudo apt update && sudo apt upgrade -y

# Gỡ phần mềm không cần thiết
echo "🧹 Gỡ bloatware..."
sudo apt purge -y hexchat thunderbird rhythmbox simple-scan libreoffice* || true
sudo apt autoremove -y

sudo apt purge -y oop tali gnome-taquin gnome-tetravex || true
sudo apt autoremove mintwelcome thunderbird hexchat hypnotix warpinator thingy sticky drawing simple-scan rhythmbox pix celluloid gnome-2048 aisleriot gnome-mahjongg gnome-mines gnome-sudoku quadrapassel five-or-more hitori iagno gnome-klotski lightsoff gnome-nibbles gnome-robots swell-f-y

# Gọi các phần phụ
source ./install_zsh.sh
source ./install_languages.sh
source ./install_gui_apt.sh
source ./install_gui_snap.sh
source ./install_rust_tools.sh

echo "✅ Thiết lập hoàn tất!"
