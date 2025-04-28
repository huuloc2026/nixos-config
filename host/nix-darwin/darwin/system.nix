{ config, pkgs, ... }: {
  imports = [ ];

  # Basic system configs
  networking.hostName = "macbook";
  programs.zsh.enable = true;
  
  environment.systemPackages = with pkgs; [
    git
    vim
    gnupg
    coreutils
    curl
    wget
    neovim
    htop
    tmux
    docker
  ];

  # Enable Nix daemon
  services.nix-daemon.enable = true;

  # MacOS defaults (example)
  system.defaults.dock.autohide = true;
  system.defaults.finder.AppleShowAllFiles = true;
  system.defaults.trackpad.Clicking = true;

  # Auto upgrade nix package
  nix.package = pkgs.nix;
  nix.extraOptions = ''
    experimental-features = nix-command flakes
  '';
}
