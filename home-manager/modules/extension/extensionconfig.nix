{ config, pkgs, ... }:

{
  dconf.settings = {
    "org/gnome/shell" = {
      enabled-extensions = [
        "system-monitor@gnome-shell-extensions.gcampax.github.com"
        "dash-to-dock@micxgx.gmail.com"
        "clipboard-indicator@tudmotu.com"
      ];
    };

    "org/gnome/shell/extensions/dash-to-dock" = {
      dock-position = "RIGHT";
      extend-height = false;
      intellihide = true;
      autohide = true;
      use-built-in-theme = true;        
      show-trash = false;     
    };
  };
}
