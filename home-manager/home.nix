{ config, pkgs, ... }:
let 
  # myAliases = import ./core/aliases.nix;
  #corePackages = import ./core/packages-core.nix { inherit pkgs; };
in
{

  home.username = "jakeonyx";
  home.homeDirectory = "/home/jakeonyx";

  home.stateVersion = "24.11"; 



  #home.packages = corePackages;

  # home.file = {

  # };

  imports = [
    ./modules/default.nix
    #Packages
    ./modules/packages-core.nix
    #Languages
    ./modules/languages.nix
    #Software
    ./modules/software.nix
    #Extension
    ./modules/extension.nix

  ];

  # home.sessionVariables = {
  # };

  home.file.".config/starship.toml".source = ./modules/starship/starship.toml;


  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
