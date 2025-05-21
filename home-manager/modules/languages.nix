# packages-core.nix
{ pkgs, ... }: {
  nixpkgs.config.allowUnfree = true;

  home.packages = with pkgs; [

  #Languages
  rustc
  typescript
  nodejs
  nodePackages.pnpm
  rust-analyzer
];
}