# packages-core.nix
{ pkgs, ... }: {
  nixpkgs.config.allowUnfree = true;

  home.packages = with pkgs; [

  #Languages
  python3Full
   python312Packages.pyautogui
  python312Packages.mouseinfo
  scrot 
  # python3-tk
  # python3-dev 
  xclip
];
}