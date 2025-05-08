#!/bin/bash

echo "🦀 Cài đặt các phần mềm được viết bằng Rust..."

# Ensure cargo is available
if ! command -v cargo &> /dev/null; then
    echo "❌ Cargo chưa được cài. Vui lòng cài Rust trước (sh https://sh.rustup.rs)."
    exit 1
fi



# Update Cargo
cargo install-update -a || echo "🆕 Nếu chưa cài 'cargo install-update', bạn có thể thêm sau."


ZSHRC="$HOME/.zshrc"
if ! grep -q 'export PATH="$HOME/.cargo/bin:$PATH"' "$ZSHRC"; then
    echo 'export PATH="$HOME/.cargo/bin:$PATH"' >> "$ZSHRC"
    export PATH="$HOME/.cargo/bin:$PATH"
    echo "✅ Đã thêm ~/.cargo/bin vào PATH."
fi

# List of popular Rust tools
declare -a tools=(
    bat         # cat clone with syntax highlighting
    exa         # ls replacement
    ripgrep     # faster grep
    fd-find     # better find
    zoxide      # smarter cd
    dust        # du alternative
    bottom      # interactive process monitor
    starship    # cross-shell prompt
    hyperfine   # benchmarking tool
    procs       # better ps
    git-delta   # git diff syntax highlighting
    lsd         # another ls replacement
)

for tool in "${tools[@]}"; do
    echo "📦 Cài đặt $tool..."
    cargo install "$tool" || echo "⚠️ Đã có hoặc lỗi cài $tool, bỏ qua."
done

# Optional: Add zoxide init and starship to .zshrc
ZSHRC="$HOME/.zshrc"

if ! grep -q "zoxide init" "$ZSHRC"; then
    echo 'eval "$(zoxide init zsh)"' >> "$ZSHRC"
fi

if ! grep -q "eval \"\$(starship init zsh)\"" "$ZSHRC"; then
    echo 'eval "$(starship init zsh)"' >> "$ZSHRC"
fi

echo "✅ Đã cài xong các tiện ích Rust CLI. Mở terminal mới hoặc run: source ~/.zshrc"
