{ config, pkgs, ... }:
let 
  myAliases = import ./aliases.nix;
in
{
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
}