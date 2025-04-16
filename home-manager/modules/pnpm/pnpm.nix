{ config, pkgs, ... }:

let
  # Define the global directories for pnpm, nodejs, and npm binaries
  pnpmHome = "${config.home.homeDirectory}/.local/share/pnpm";
  nodejsBin = "${pkgs.nodejs}/bin";
  npmBin = "${config.home.homeDirectory}/.npm-global/bin";  # Assuming you have a global npm directory
in
{
  home.sessionVariables = {
    PNPM_HOME = pnpmHome;
    PATH = "${pnpmHome}:${nodejsBin}:${npmBin}:${config.home.profileDirectory}/bin:$PATH";
  };
}
