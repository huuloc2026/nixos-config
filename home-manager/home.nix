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
    #Software
    ./modules/software.nix

    #Pnpm config
 
    #./modules/pnpm/pnpm.nix 
    # #Extension
    ./modules/extension/extension.nix
    # #Enable config extension
    ./modules/extension/extensionconfig.nix
  ];



  # home.sessionVariables = {
  # };

  #home.file.".config/starship.toml".source = ./modules/starship/starship.toml;
  #home.file.".config/zellij/config.kdl".source = ./modules/zellij/config.kdl;


  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
