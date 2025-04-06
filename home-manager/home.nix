{ config, pkgs, ... }:
let 
  myAliases = import ./core/aliases.nix;
  corePackages = import ./core/packages-core.nix;
in
{

  home.username = "jakeonyx";
  home.homeDirectory = "/home/jakeonyx";

  home.stateVersion = "24.11"; 

  home.packages = corePackages;

  # home.file = {

  # };


  # home.sessionVariables = {
  # };

 programs.zsh= {
    enable = true;
    shellAliases = myAliases; 
    oh-my-zsh.enable = true;
    oh-my-zsh.plugins = [ "git" "node" "docker" ];
    
};

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
