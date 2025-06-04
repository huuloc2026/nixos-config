# packages-core.nix
{ pkgs, ... }: {
  nixpkgs.config.allowUnfree = true;

  home.packages = with pkgs; [
  # Core 
  tree
  yazi
  xclip
  eza
  unzip
  zip
  bat
  fd
  git
  fzf
  ripgrep
  ripgrep-all
  curl
  jq
  wget
  #gnumake
  gcc
  cmake
  neofetch
  unrar
  libreoffice
  #font
  (nerdfonts.override { fonts = [ "FiraCode" "JetBrainsMono" ]; })

  zellij
  docker
  docker-compose
  #extension


];
}
