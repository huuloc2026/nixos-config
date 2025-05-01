# packages-core.nix
{ pkgs, ... }: {
  nixpkgs.config.allowUnfree = true;

  environment.systemPackages = with pkgs; [
 papirus-icon-theme     
  orchis-theme
gtk-engine-murrine
sassc

#WhiteSur
whitesur-gtk-theme
# Whitesur-icon-theme
whitesur-cursors
plank
];
}
