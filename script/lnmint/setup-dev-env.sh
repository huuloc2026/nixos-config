#!/bin/bash

set -e

echo "🛠️  Setting up Developer Environment on Linux Mint..."

# Update system
sudo apt update && sudo apt upgrade -y


# ----------------------------
# Install Essential Packages
# ----------------------------
sudo apt install -y curl wget git build-essential unzip \
  zsh gnupg lsb-release ca-certificates \
   fzf fonts-firacode \
  python3 python3-pip python3-venv cmake pkg-config \
  libfreetype6-dev libfontconfig1-dev libxcb-xfixes0-dev

# NVM (optional for node version switching)
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.7/install.sh | bash

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"

# Add to ~/.zshrc
echo 'export NVM_DIR="$HOME/.nvm"' >> ~/.zshrc
echo '[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"' >> ~/.zshrc



# Git config
git config --global user.name "HuuLoc"
git config --global user.email "huuloc2026@email.com"
git config --global init.defaultBranch main

# ----------------------------
# Node.js (LTS) via NodeSource
# ----------------------------
curl -fsSL https://deb.nodesource.com/setup_lts.x | sudo -E bash -
sudo apt install -y nodejs

# ----------------------------
# Python 3 & pip
# ----------------------------
sudo apt install -y python3 python3-pip python3-venv

# ----------------------------
# Go (latest from official)
# ----------------------------
GO_VERSION=$(curl -s https://go.dev/VERSION?m=text)
wget https://go.dev/dl/${GO_VERSION}.linux-amd64.tar.gz
sudo tar -C /usr/local -xzf ${GO_VERSION}.linux-amd64.tar.gz
echo 'export PATH=$PATH:/usr/local/go/bin' >> ~/.profile
rm ${GO_VERSION}.linux-amd64.tar.gz

# ----------------------------
# Rust (via rustup)
# ----------------------------
curl https://sh.rustup.rs -sSf | sh -s -- -y
source "$HOME/.cargo/env"
echo 'source $HOME/.cargo/env' >> ~/.zshrc
echo 'export PATH="$HOME/.cargo/bin:$PATH"' >> ~/.profile

# ----------------------------
# Docker
# ----------------------------
sudo apt install -y docker.io docker-compose
sudo usermod -aG docker $USER

# ----------------------------
# Zsh & Oh My Zsh
# ----------------------------
sudo apt install -y zsh
chsh -s $(which zsh)

# Oh My Zsh install
export RUNZSH=no
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# Powerlevel10k
ZSH_CUSTOM=${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git \
  ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/themes/powerlevel10k
sed -i 's/^ZSH_THEME=.*/ZSH_THEME="powerlevel10k\/powerlevel10k"/' ~/.zshrc
echo '[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh' >> ~/.zshrc
# zsh plugins
git clone https://github.com/zsh-users/zsh-autosuggestions \
  ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting \
  ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting

# Auto add plugins to .zshrc
sed -i '/^plugins=/c\plugins=(git zsh-autosuggestions zsh-syntax-highlighting)' ~/.zshrc

# Source plugin settings
echo 'source ${(q-)ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh' >> ~/.zshrc
echo 'source ${(q-)ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh' >> ~/.zshrc

# ----------------------------
# Fonts (Fira Code)
# ----------------------------
sudo apt install -y fonts-firacode

# ----------------------------
# VS Code
# ----------------------------
wget -qO- https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > packages.microsoft.gpg
sudo install -o root -g root -m 644 packages.microsoft.gpg /etc/apt/trusted.gpg.d/
sudo sh -c 'echo "deb [arch=amd64] https://packages.microsoft.com/repos/vscode stable main" \
  > /etc/apt/sources.list.d/vscode.list'
sudo apt update
sudo apt install -y code
rm packages.microsoft.gpg

# ----------------------------
# Brave Browser
# ----------------------------
sudo curl -fsSLo /usr/share/keyrings/brave-browser-archive-keyring.gpg \
  https://brave.com/signing-key.gpg
echo "deb [signed-by=/usr/share/keyrings/brave-browser-archive-keyring.gpg arch=amd64] \
  https://brave-browser-apt-release.s3.brave.com/ stable main" | \
  sudo tee /etc/apt/sources.list.d/brave-browser-release.list
sudo apt update
sudo apt install -y brave-browser

# ----------------------------
# Telegram Desktop
# ----------------------------
sudo apt install -y telegram-desktop


# ----------------------------
# GitHub CLI
# ----------------------------

type -p curl >/dev/null || sudo apt install curl -y
curl -fsSL https://cli.github.com/packages/githubcli-archive-keyring.gpg | \
  sudo dd of=/usr/share/keyrings/githubcli-archive-keyring.gpg
sudo chmod go+r /usr/share/keyrings/githubcli-archive-keyring.gpg
echo "deb [arch=amd64 signed-by=/usr/share/keyrings/githubcli-archive-keyring.gpg] \
  https://cli.github.com/packages stable main" | \
  sudo tee /etc/apt/sources.list.d/github-cli.list > /dev/null
sudo apt update
sudo apt install -y gh




# ----------------------------
# Alacritty (GPU-accelerated terminal)
# ----------------------------
sudo apt install -y cmake pkg-config libfreetype6-dev libfontconfig1-dev libxcb-xfixes0-dev python3
cargo install --git https://github.com/alacritty/alacritty
echo 'alias term="alacritty"' >> ~/.zsh_aliases

# ----------------------------
# Zellij (Terminal multiplexer like tmux)
# ----------------------------
cargo install zellij
echo 'alias zj="zellij"' >> ~/.zsh_aliases

# ----------------------------
# Helix Editor
# ----------------------------
HELIX_VERSION="23.10"
wget https://github.com/helix-editor/helix/releases/download/${HELIX_VERSION}/helix-${HELIX_VERSION}-x86_64.AppImage -O ~/helix.AppImage
chmod +x ~/helix.AppImage
sudo mv ~/helix.AppImage /usr/local/bin/hx


# ----------------------------
# Neovim (Latest via PPA)
# ----------------------------
sudo add-apt-repository ppa:neovim-ppa/stable -y
sudo apt update
sudo apt install -y neovim
echo 'alias vi="nvim"' >> ~/.zsh_aliases

# ----------------------------
# Other
# ----------------------------
cargo install bat exa ripgrep fd-find du-dust bottom hyperfine tokei just git-delta procs

# ----------------------------
# Alias File Management
# ----------------------------
touch ~/.zsh_aliases
if ! grep -Fxq 'source ~/.zsh_aliases' ~/.zshrc; then
  echo '[ -f ~/.zsh_aliases ] && source ~/.zsh_aliases' >> ~/.zshrc
fi

# Add useful aliases
cat <<'EOF' >> ~/.zsh_aliases
# === Git ===
alias gs='git status'
alias gc='git commit -m'
alias gp='git push'

# === Directory Navigation ===
alias ..='cd ..'
alias ....='cd ../../'
alias dev='cd ~/Projects'
alias gh='cd ~ && clear && echo "🦥 Went back home - Jake Onyx"'

# === LS & Clear ===
alias ll='ls -alF'
alias la='ls -la'
alias c='clear'

# === Safer Commands ===
alias rm='rm -i'
alias grep='grep --color=auto'

# === Editors ===
alias vi='nvim'


# === Docker ===
alias dcu='docker compose up -d'
alias dcd='docker compose down'
alias dcps='docker compose ps'

# === Personal Shortcut ===
alias mg='brave "https://github.com/huuloc2026?tab=repositories"'

EOF

# ----------------------------
# Finalizing
# ----------------------------
echo 'export PATH=$PATH:/usr/local/go/bin:$HOME/.cargo/bin' >> ~/.zshrc

echo 'source ~/.profile' >> ~/.zshrc

echo "✅ Done! Please restart your terminal or run 'source ~/.zshrc'"


echo "📦 Checking installed versions..."

echo "🔧 Git: $(git --version)"
echo "🌐 Curl: $(curl --version | head -n1)"
echo "📥 Wget: $(wget --version | head -n1)"
echo "🧰 Build Tools: $(gcc --version | head -n1)"
echo "🐍 Python: $(python3 --version)"
echo "📦 Pip: $(pip3 --version)"
echo "🔄 Node: $(node -v)"
echo "📦 NPM: $(npm -v)"
echo "🦫 Go: $(go version)"
echo "🦀 Rust: $(rustc --version)"
echo "📦 Cargo: $(cargo --version)"
echo "🐳 Docker: $(docker --version)"
echo "🐙 Docker Compose: $(docker compose version)"
echo "💻 Zsh: $(zsh --version)"
echo "🖋️ Neovim: $(nvim --version | head -n1)"
echo "🔠 Alacritty: $(alacritty --version)"
echo "📦 Helix: $(hx --version)"
echo "🧱 Zellij: $(zellij --version)"
echo "🐈 bat: $(bat --version)"
echo "🔍 ripgrep: $(rg --version | head -n1)"
echo "🔎 fzf: $(fzf --version)"
echo "📁 exa: $(exa --version)"
echo "📊 bottom: $(btm --version)"
echo "⚙️ just: $(just --version)"
echo "📚 tokei: $(tokei --version)"
echo "📈 hyperfine: $(hyperfine --version)"
echo "🔀 procs: $(procs --version)"
echo "🌍 gh (GitHub CLI): $(gh --version | head -n1)"

echo "✅ All tool versions checked."
