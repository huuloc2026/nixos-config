# packages-core.nix
{ pkgs, ... }: {
  nixpkgs.config.allowUnfree = true;

  home.packages = with pkgs; [

  gnome-tweaks
  gnomeExtensions.dash-to-dock
  gnomeExtensions.clipboard-indicator

];
}