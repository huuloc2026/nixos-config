# packages-core.nix
{ pkgs, ... }: 
  #nixpkgs.config.allowUnfree = true;

  with pkgs; [
  # Core 
  tree
  eza
  bat
  fd
  htop
  ripgrep
  vim
  neovim
  git
  fzf
  tree
  ripgrep-all
  docker
  docker-compose
  curl
  jq
  zellij
  pnpm
  wget
  cmake

  #Languages
  rustc
  go
  typescript
  python3
  nodejs
  ruby
  rust-analyzer
  go-tools

  #extension

  gnome-tweaks
  gnomeExtensions.dash-to-dock
  gnomeExtensions.clipboard-indicator
  #Software
  vscode
  telegram-desktop
  brave
  postman
  keepassxc
]

