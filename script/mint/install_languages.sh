#!/bin/bash

echo "🧰 Cài ngôn ngữ lập trình & môi trường container..."

# Core tools
sudo apt install -y build-essential zip unzip htop net-tools software-properties-common gnupg lsb-release ca-certificates apt-transport-https curl wget

# --- Cài Node.js qua NVM ---
echo "🟢 Cài đặt NVM & Node.js..."
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.3/install.sh | bash
export NVM_DIR="$HOME/.nvm"
source "$NVM_DIR/nvm.sh"
echo "source $NVM_DIR/nvm.sh" >> ~/.zshrc
nvm install --lts
nvm use --lts

# --- Cài Python ---
echo "🐍 Cài đặt Python..."
sudo apt install -y python3 python3-pip

# --- Cài Go ---
echo "🐹 Cài đặt Go..."
sudo apt install -y golang-go

# --- Cài Rust ---
echo "🦀 Cài đặt Rust & Cargo..."
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
source "$HOME/.cargo/env"
echo "source \$HOME/.cargo/env" >> ~/.zshrc

# --- Cài Docker ---
echo "🐳 Cài đặt Docker..."
sudo apt remove -y docker docker-engine docker.io containerd runc || true

# Thêm Docker repo
sudo install -m 0755 -d /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg

echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] \
  https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

# Cài Docker CE
sudo apt update
sudo apt install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

# Thêm user vào nhóm docker
sudo usermod -aG docker $USER

echo "✅ Docker đã được cài đặt. Bạn cần *logout/login* để sử dụng Docker mà không cần sudo."
