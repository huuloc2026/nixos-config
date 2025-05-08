#!/bin/bash

echo "🐚 Cài đặt Zsh & plugin..."

sudo apt install -y zsh git curl wget

export RUNZSH=no
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

ZSH_CUSTOM=${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}

git clone https://github.com/zsh-users/zsh-autosuggestions "$ZSH_CUSTOM/plugins/zsh-autosuggestions" || true
git clone https://github.com/zsh-users/zsh-syntax-highlighting "$ZSH_CUSTOM/plugins/zsh-syntax-highlighting" || true
git clone https://github.com/zsh-users/zsh-completions "$ZSH_CUSTOM/plugins/zsh-completions" || true

ZSHRC="$HOME/.zshrc"
if grep -q "^plugins=" "$ZSHRC"; then
    sed -i 's/^plugins=.*/plugins=(git zsh-autosuggestions zsh-syntax-highlighting  zsh-completions)/' "$ZSHRC"
else
    echo 'plugins=(git zsh-autosuggestions zsh-syntax-highlighting  zsh-completions)' >> "$ZSHRC"
fi

cat <<EOF >> "$ZSHRC"

# Plugin configs
source $ZSH_CUSTOM/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source $ZSH_CUSTOM/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh

EOF

chsh -s $(which zsh)
echo "✅ Đặt Zsh làm shell mặc định."
