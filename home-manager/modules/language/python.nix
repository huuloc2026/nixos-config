# packages-core.nix
{ pkgs, ... }: {
  nixpkgs.config.allowUnfree = true;

  home.packages = with pkgs; [

  #Languages
  python3Full
  pkgs.python3Packages.pyautogui  
  python312Full
  python312Packages.pyautogui
  python312Packages.mouseinfo
  scrot 
  # python3-tk
  # python3-dev 
  xclip
];
}