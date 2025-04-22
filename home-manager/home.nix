{ config, pkgs, ... }:

{

  home.username = "jakeonyx";
  home.homeDirectory = "/home/jakeonyx";
  home.stateVersion = "24.11"; 
  imports = [
    ./modules/default.nix
    #Packages
    ./modules/packages-core.nix
    #Languages
    ./modules/languages.nix
    #TODO: remind update. Just have python
    ./modules/language/default.nix


    #Software
    ./modules/software.nix

    
    #Pnpm config
    #./modules/pnpm/pnpm.nix 
    # #Extension
    # ./modules/extension/extension.nix
    # # #Enable config extension
    # ./modules/extension/extensionconfig.nix
  ];


  # home.sessionVariables = {
  # };

  # home.file.".local/share/wallpapers/mywall.jpg".source = ../wallpapers/3d-neon-leaves-cgi-cyberpunk-black-background-glowing-3840x2160-3230.jpg;


  #  dconf.settings = {
  #   "org/gnome/desktop/background" = {
  #     picture-uri = "file:///home/jakeonyx/Pictures/wallpapers/mywall.jpg";
  #     picture-options = "zoom"; # Hoặc 'scaled', 'centered', v.v.
  #   };
  # };


  # home.file.".config/nvim" = {
  # source = ./modules/nvim;    
  # force = true;  
  # };

  # programs.dconf.enable = true;
  


  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
