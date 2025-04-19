{ config, pkgs, ... }:

{
  services.xserver.windowManager.i3.enable = true;

  environment.systemPackages = with pkgs; [
    i3status rofi feh picom i3lock xautolock pamixer clipmenu xclip
  ];

  xdg.configFile."i3/config".source = ./../../i3_minimal_config/.config/i3/config;
  xdg.configFile."picom/picom.conf".source = ./../../i3_minimal_config/.config/picom/picom.conf;
  xdg.configFile."rofi/theme.rasi".source = ./../../i3_minimal_config/.config/rofi/theme.rasi;
  xdg.configFile."i3status/config".source = ./../../i3_minimal_config/.config/i3status/config;
}
