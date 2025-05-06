{ lib, pkgs, ... }: {
  programs.alacritty = {
    enable = true;
    settings = {
      
      colors = {
        normal = {
          black = "0x45475a";
          blue = "0x89b4fa";
          cyan = "0x94e2d5";
          green = "0xa6e3a1";
          magenta = "0xcba6f7";
          red = "0xf38ba8";
          white = "0xcdd6f4";
          yellow = "0xf9e2af";
        };
        primary = {
          background = "0x1e1e2e";
          foreground = "0xcdd6f4";
        };
      };
      
      font = {
        size = 12.0;
        normal = {
          family = "JetBrainsMono Nerd Font";
          style = lib.mkForce "Bold";
        };
      };


      window = {
        opacity = 0.95;
        
        dimensions = {
          columns = 100;
          lines = 30;
        };
        padding = {
          x = 10;
          y = 10;
        };
      };

      
      
      # terminal.shell = {
      #   args = ["new-session"  "-A"  "-D" "-s" "main"];
      #   program = "/${pkgs.zellij}/bin/zellij";
      # };
      
    };
  };
}
