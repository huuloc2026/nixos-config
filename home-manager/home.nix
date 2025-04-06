{ config, pkgs, ... }:
let 
  myAliases = import ./core/aliases.nix;
  corePackages = import ./core/packages-core.nix { inherit pkgs; };
in
{

  home.username = "jakeonyx";
  home.homeDirectory = "/home/jakeonyx";

  home.stateVersion = "24.11"; 

  environment.systemPackages = with pkgs; [
     gnome-tweaks
    gnomeExtensions.dash-to-dock
    gnomeExtensions.clipboard-indicator
  ];
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
    initExtra = ''
      if [ -e "$HOME/.nix-profile/etc/profile.d/nix.sh" ]; then
        source "$HOME/.nix-profile/etc/profile.d/nix.sh"
      fi
      export PATH="$HOME/.nix-profile/bin:$PATH"
    '';
    
};

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
