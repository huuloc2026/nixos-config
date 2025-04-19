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
  git
  fzf
  ripgrep
  ripgrep-all
  docker
  docker-compose
  curl
  jq
  zellij
  wget
  #gnumake
  gcc
  cmake
  neofetch
  unrar

  #font
  (nerdfonts.override { fonts = [ "FiraCode" "JetBrainsMono" ]; })

  #extension

  gnome-tweaks
  gnomeExtensions.dash-to-dock
  gnomeExtensions.clipboard-indicator

];
}
