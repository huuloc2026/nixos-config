{ config, pkgs, ... }:

let
  pnpmHome = "${config.home.homeDirectory}/.local/share/pnpm";
in
{
  home.sessionVariables = {
    PNPM_HOME = pnpmHome;
    PATH = "${pnpmHome}:${config.home.profileDirectory}/bin:$PATH";
  };

  home.file.".local/share/pnpm".source = pkgs.runCommand "create-pnpm-home" {} ''
    mkdir -p $out
  '';

}
