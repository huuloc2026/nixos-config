# packages-core.nix
{ pkgs, ... }: {
  nixpkgs.config.allowUnfree = true;

  home.packages = with pkgs; [

  #Software
  vscode
  telegram-desktop
  brave
  postman
  keepassxc
];
}