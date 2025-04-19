{ config, pkgs, ... }:
{
programs.helix = {
  enable = true;
};
 home.file.".config/helix/config.toml" = {
  source = ./config.toml;  
  force = true;
  };
   home.file.".config/helix/languages.toml" = {
  source = ./languages.toml;  
  force = true;
  };
}
