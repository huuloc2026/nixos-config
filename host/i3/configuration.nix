# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{

  #Zsh default shell
  environment.shells = with pkgs; [ zsh ];
  users.defaultUserShell = pkgs.zsh;
  programs.zsh.enable = true;

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  networking.hostName = "nixos"; # 
 

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "Asia/Ho_Chi_Minh";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "vi_VN";
    LC_IDENTIFICATION = "vi_VN";
    LC_MEASUREMENT = "vi_VN";
    LC_MONETARY = "vi_VN";
    LC_NAME = "vi_VN";
    LC_NUMERIC = "vi_VN";
    LC_PAPER = "vi_VN";
    LC_TELEPHONE = "vi_VN";
    LC_TIME = "vi_VN";
  };

  # Enable the X11 windowing system.
  services.xserver.enable = true;
  services.xserver.windowManager.i3.enable = true;
  services.xserver.displayManager.gdm.enable = true;
  
  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };
  
  #Input Method Vietnamese
  i18n.inputMethod = {
  enabled = "fcitx5";
  fcitx5.addons = with pkgs; [ fcitx5-bamboo ];
  };

  # Enable sound with pipewire.
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    #jack.enable = true;
  };

  # Enable touchpad support (enabled default in most desktopManager).
  services.xserver.libinput.enable = false;

  users.users.jakeonyx = {
    isNormalUser = true;
    description = "jakeonyx";
    extraGroups = [ "networkmanager" "wheel" ]; 
    packages = with pkgs; [
    #  thunderbird
    ];
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
      # Dev tools
    git gcc wget curl neovim

    # Trình duyệt + chat
    telegram-desktop
    brave

    # # Terminal & launcher
    # xterm
    # dmenu
    # rofi

    # # Giao diện
    # lxappearance
    # feh         # Wallpaper
    # picom       # Compositor

    # # Clipboard manager
    # clipmenu
    # xclip

    # # System monitor
    # btop

    # # Âm lượng
    # pavucontrol
    # pamixer

    # # Khoá màn hình
    # i3lock
    # xautolock

    # # Status bar
    # i3status
  ];

  imports = [
    ./desktop/i3/i3.nix

    ./hardware-configuration.nix
  ];

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;

  virtualisation.docker.enable = true;
  
  system.stateVersion = "24.11"; # Did you read the comment?

}
