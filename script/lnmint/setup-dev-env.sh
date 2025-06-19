#!/bin/bash

echo "🛠️  Setting up Developer Environment on Linux Mint..."

# Update & Upgrade
sudo apt update && sudo apt upgrade -y

# Essential Tools
sudo apt install -y curl wget git build-essential zsh unzip tmux neofetch htop

# Git setup
git config --global user.name "Your Name"
git config --global user.email "your@email.com"
git config --global init.defaultBranch main

# Install Node.js (LTS)
curl -fsSL https://deb.nodesource.com/setup_lts.x | sudo -E bash -
sudo apt install -y nodejs

# Install Python 3, pip, virtualenv
sudo apt install -y python3 python3-pip python3-venv

# Install Go
GO_VERSION="1.22.3"
wget https://go.dev/dl/go$GO_VERSION.linux-amd64.tar.gz
sudo tar -C /usr/local -xzf go$GO_VERSION.linux-amd64.tar.gz
echo 'export PATH=$PATH:/usr/local/go/bin' >> ~/.bashrc
rm go$GO_VERSION.linux-amd64.tar.gz

# Docker
sudo apt install -y docker.io docker-compose
sudo usermod -aG docker $USER

# NVM (optional for node version switching)
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.7/install.sh | bash

# Zsh & Oh My Zsh
sudo apt install -y zsh
chsh -s $(which zsh)
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# VS Code
wget -qO- https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > packages.microsoft.gpg
sudo install -o root -g root -m 644 packages.microsoft.gpg /etc/apt/trusted.gpg.d/
sudo sh -c 'echo "deb [arch=amd64] https://packages.microsoft.com/repos/vscode stable main" > /etc/apt/sources.list.d/vscode.list'
sudo apt update
sudo apt install -y code
rm packages.microsoft.gpg

# Fonts (Fira Code for coding)
sudo apt install -y fonts-firacode

# Final setup
source ~/.bashrc
echo "✅ Developer environment setup complete. Restart terminal to apply changes."

# Install Powerlevel10k
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/themes/powerlevel10k

# Set ZSH_THEME in ~/.zshrc
sed -i 's/^ZSH_THEME=.*/ZSH_THEME="powerlevel10k\/powerlevel10k"/' ~/.zshrc

# zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions

# zsh-syntax-highlighting
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting

# Add to ~/.zshrc
plugins=(git zsh-autosuggestions zsh-syntax-highlighting)
