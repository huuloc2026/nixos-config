# packages-core.nix
{ pkgs, ... }: {
  nixpkgs.config.allowUnfree = true;

  home.packages = with pkgs; [
  # Core 
  tree
  eza
  unzip
  zip
  bat
  fd
  htop
  ripgrep
  git
  fzf
  ripgrep-all
  docker
  docker-compose
  curl
  jq
  zellij
  pnpm
  wget
  cmake

  

  #extension

  gnome-tweaks
  gnomeExtensions.dash-to-dock
  gnomeExtensions.clipboard-indicator

];
}