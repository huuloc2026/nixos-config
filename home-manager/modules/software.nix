# packages-core.nix
{ pkgs, ... }: {
  nixpkgs.config.allowUnfree = true;

  home.packages = with pkgs; [

  #Software
  vlc
  vscode
  telegram-desktop
  brave
  postman
  keepassxc
  dbeaver-bin
  anki
  #redisinsight


];
}