#!/bin/zsh
set -e

echo "🛠️ Setting up Developer Environment on Linux Mint..."

# Variables
GIT_USER_NAME="HuuLoc"
GIT_USER_EMAIL="huuloc2026@email.com"
HELIX_VERSION="23.10"
GO_VERSION="go1.24.4"

# Function to check if a command exists
command_exists() {
  command -v "$1" &>/dev/null
}

echo "🔄 Updating system packages..."
sudo apt update && sudo apt upgrade -y

echo "📦 Installing essential system packages and C++ development tools..."
sudo apt install -y curl git build-essential vim unzip \
  zsh gnupg lsb-release ca-certificates \
  fzf fonts-firacode \
  python3 python3-pip cmake pkg-config \
  libfreetype6-dev libfontconfig1-dev libxcb-xfixes0-dev \
  g++ libssl-dev libcurl4-openssl-dev jq

echo "⚙️ Configuring Git..."
git config --global user.name "$GIT_USER_NAME"
git config --global user.email "$GIT_USER_EMAIL"
git config --global init.defaultBranch main

if [ ! -d "$HOME/.nvm" ]; then
  curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.7/install.sh | bash
  export NVM_DIR="$HOME/.nvm"
  [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
  if ! grep -q 'export NVM_DIR="$HOME/.nvm"' ~/.zshrc; then
    echo '' >> ~/.zshrc
    echo '# NVM - Node Version Manager' >> ~/.zshrc
    echo 'export NVM_DIR="$HOME/.nvm"' >> ~/.zshrc
    echo '[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"' >> ~/.zshrc
  fi
  nvm install --lts
  nvm use --lts
  nvm alias default 'lts/*'
else
  echo "NVM already installed."
  export NVM_DIR="$HOME/.nvm"
  [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
  nvm install --lts &>/dev/null || true
  nvm use --lts &>/dev/null || true
fi



echo "🐹 Checking Go installation..."
GO_TAR="${GO_VERSION}.linux-amd64.tar.gz"
GO_URL="https://go.dev/dl/${GO_TAR}"
EXPECTED_GO_VERSION_NUMBER="${GO_VERSION/go/}"

CURRENT_GO_VERSION_OUTPUT=""
if command_exists go; then
    CURRENT_GO_VERSION_OUTPUT=$(go version 2>/dev/null)
fi

INSTALLED_GO_VERSION=""
if [[ "$CURRENT_GO_VERSION_OUTPUT" =~ go([0-9]+\.[0-9]+\.[0-9]+|tip) ]]; then
    INSTALLED_GO_VERSION="${match[1]}"
fi

if [[ "$INSTALLED_GO_VERSION" == "$EXPECTED_GO_VERSION_NUMBER" ]]; then
  echo "✅ Go ${GO_VERSION} is already installed. Skipping."
else
  echo "Installing Go ${GO_VERSION}..."
  curl -sSL -o "${GO_TAR}" "${GO_URL}"
  sudo rm -rf /usr/local/go
  sudo tar -C /usr/local -xzf "${GO_TAR}"
  rm "${GO_TAR}"
  PROFILE_FILE="$HOME/.zshrc"
  if ! grep -q 'export PATH=.*:/usr/local/go/bin' "$PROFILE_FILE"; then
    echo '' >> "$PROFILE_FILE"
    echo '# Go Language Path' >> "$PROFILE_FILE"
    echo 'export PATH=$PATH:/usr/local/go/bin' >> "$PROFILE_FILE"
  fi
  echo "✅ Go ${GO_VERSION} installed successfully!"
fi

echo "🦀 Installing Rust (via rustup)..."
if ! command_exists rustc; then
  curl https://sh.rustup.rs -sSf | sh -s -- -y
  source "$HOME/.cargo/env"
else
  echo "Rust already installed. Skipping."
fi
if ! grep -q 'source "$HOME/.cargo/env"' ~/.zshrc; then
  echo '' >> ~/.zshrc
  echo '# Rust Language Environment' >> ~/.zshrc
  echo 'source "$HOME/.cargo/env"' >> ~/.zshrc
fi

echo "🐳 Installing Docker and Docker Compose..."
if ! command_exists docker; then
  sudo apt install -y docker.io docker-compose
  sudo usermod -aG docker "$USER"
  echo "Docker installed. Please log out and log back in for group changes to take effect."
else
  echo "Docker already installed. Skipping."
fi

echo "💻 Setting up Zsh and Oh My Zsh..."
if [ "$(basename "$SHELL")" != "zsh" ]; then
  chsh -s "$(which zsh)"
  echo "Default shell changed. Please log out and log in again."
fi

echo "⌨️ Installing IBus and Vietnamese Unikey..."
if ! dpkg -s ibus-unikey &>/dev/null; then
  sudo apt install -y ibus ibus-gtk ibus-gtk3 ibus-clutter ibus-unikey
  sudo im-config -n ibus
fi

if [ ! -d "$HOME/.oh-my-zsh" ]; then
  export RUNZSH=no
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
fi

echo "✨ Installing Starship shell prompt..."
if ! command_exists starship; then
  curl -sS https://starship.rs/install.sh | sh -s -- -y
fi
if ! grep -q 'eval "$(starship init zsh)"' ~/.zshrc; then
  echo '' >> ~/.zshrc
  echo '# Starship Prompt' >> ~/.zshrc
  echo 'eval "$(starship init zsh)"' >> ~/.zshrc
fi

echo "🔌 Installing Zsh plugins..."
ZSH_CUSTOM_DIR="${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}"
PLUGINS_TO_INSTALL=(zsh-autosuggestions zsh-syntax-highlighting)
for plugin in "${PLUGINS_TO_INSTALL[@]}"; do
    if [ ! -d "${ZSH_CUSTOM_DIR}/plugins/${plugin}" ]; then
        git clone "https://github.com/zsh-users/${plugin}" "${ZSH_CUSTOM_DIR}/plugins/${plugin}"
    fi
done
sed -i 's/^plugins=(.*/plugins=(git zsh-autosuggestions zsh-syntax-highlighting)/' ~/.zshrc

echo "🖥️ Installing VS Code..."
if ! command_exists code; then
  curl -fsSL https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > packages.microsoft.gpg
  sudo install -o root -g root -m 644 packages.microsoft.gpg /etc/apt/trusted.gpg.d/
  echo "deb [arch=amd64] https://packages.microsoft.com/repos/vscode stable main" | sudo tee /etc/apt/sources.list.d/vscode.list > /dev/null
  sudo apt update
  sudo apt install -y code
  rm packages.microsoft.gpg
fi

echo "🌍 Installing Brave Browser..."
if ! command_exists brave-browser; then
  curl -fsS https://dl.brave.com/install.sh | sudo bash
fi

echo "📝 Installing Helix Editor..."
if ! command_exists hx; then
  curl -L -o ~/helix.AppImage https://github.com/helix-editor/helix/releases/download/${HELIX_VERSION}/helix-${HELIX_VERSION}-x86_64.AppImage
  chmod +x ~/helix.AppImage
  sudo mv ~/helix.AppImage /usr/local/bin/hx
fi

echo "🐍 Installing Python libraries..."
if command_exists pip3; then
  pip3 install --no-cache-dir numpy pandas jupyterlab proselint
fi

echo "🚀 Installing Rust-based CLI tools..."
source "$HOME/.cargo/env"
RUST_TOOLS=(alacritty zellij zoxide bat eza ripgrep fd-find du-dust bottom hyperfine tokei just git-delta procs)
for tool in "${RUST_TOOLS[@]}"; do
  if ! command_exists "$tool"; then
    echo "Installing $tool..."
    cargo install "$tool" || echo "⚠️ Failed to install $tool."
  fi
done
echo "📜 Setting up custom aliases..."

# Ghi đè hoàn toàn ~/.zsh_aliases
cat <<'EOF' > ~/.zsh_aliases
# Custom
alias ..='cd ..'
alias ...='cd ../..'
alias c='clear'
alias rl='source ~/.zshrc'
alias dev='cd ~/Projects'
alias gh='cd ~ && clear && echo "🦥 Went back home - Jake Onyx"'

# Rust Tools
alias l='eza'
alias ll='eza -alF --icons --git'
alias la='eza -a'
alias grep='rg --color=auto'
alias fd='fd'
alias dust='du-dust'
alias bt='btm'
alias p='procs'
alias zj='zellij'
alias term='alacritty'

# Git
alias gs='git status'
alias gl='git log --oneline --graph --decorate'
alias gc='git commit -m'
alias ga='git add .'
alias gpl='git pull'
alias gps='git push'

# Docker
alias dcu='docker-compose up -d'
alias dcd='docker-compose down'

# Jupyter
alias jl='jupyter lab'

# Personal
alias mg='brave-browser "https://github.com/huuloc2026?tab=repositories"'

EOF

# Đảm bảo ~/.zshrc sẽ load alias
if ! grep -q 'source ~/.zsh_aliases' ~/.zshrc; then
  echo '' >> ~/.zshrc
  echo '# Load Custom Aliases' >> ~/.zshrc
  echo '[ -f ~/.zsh_aliases ] && source ~/.zsh_aliases' >> ~/.zshrc
fi


if ! grep -q 'eval "$(zoxide init zsh)"' ~/.zshrc; then
  echo '' >> ~/.zshrc
  echo '# Zoxide (Smart cd)' >> ~/.zshrc
  echo 'eval "$(zoxide init zsh)"' >> ~/.zshrc
fi

if [ -f ~/.profile ] && ! grep -q 'source ~/.profile' ~/.zshrc; then
  echo '[ -f ~/.profile ] && source ~/.profile' >> ~/.zshrc
fi
sudo apt remove firefox
sudo apt autoremove -y

echo ""
echo "🎉 Environment setup complete!"
echo "👉 Please restart your terminal or run 'source ~/.zshrc' to apply all changes."

echo ""
echo "--- 📦 Verifying Installed Tool Versions ---"
echo "🔧 Git: $(git --version 2>/dev/null || echo 'Not found')"
echo "🌐 Curl: $(curl --version 2>/dev/null | head -n1 || echo 'Not found')"
echo "🐍 Python: $(python3 --version 2>/dev/null || echo 'Not found')"
echo "📦 Pip: $(pip3 --version 2>/dev/null | head -n1 || echo 'Not found')"
echo "🔄 Node: $(node -v 2>/dev/null || echo 'Not found')"
echo "🦫 Go: $(go version 2>/dev/null || echo 'Not found')"
echo "🦀 Rust: $(rustc --version 2>/dev/null || echo 'Not found')"
echo "🐳 Docker: $(docker --version 2>/dev/null || echo 'Not found')"
echo "💻 Zsh: $(zsh --version 2>/dev/null || echo 'Not found')"
echo "✨ Starship: $(starship --version 2>/dev/null || echo 'Not found')"
echo "🔠 Alacritty: $(alacritty --version 2>/dev/null || echo 'Not found')"
echo "📦 Helix: $(hx --version 2>/dev/null || echo 'Not found')"
echo "🧱 Zellij: $(zellij --version 2>/dev/null || echo 'Not found')"
echo "🐈 bat: $(bat --version 2>/dev/null || echo 'Not found')"
echo "📁 eza: $(eza --version 2>/dev/null || echo 'Not found')"
echo "🔍 ripgrep: $(rg --version 2>/dev/null || echo 'Not found')"
echo "🔎 fzf: $(fzf --version 2>/dev/null || echo 'Not found')"
echo "🔎 fd-find: $(fd --version 2>/dev/null || echo 'Not found')"
echo "📊 bottom: $(btm --version 2>/dev/null || echo 'Not found')"
echo "💡 zoxide: $(zoxide --version 2>/dev/null || echo 'Not found')"
echo "--- ✅ All tool versions checked. ---"
