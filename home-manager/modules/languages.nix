# packages-core.nix
{ pkgs, ... }: {
  nixpkgs.config.allowUnfree = true;

  home.packages = with pkgs; [

  #Languages
  rustc
  go
  typescript
  nodejs
  nodePackages.pnpm
  rust-analyzer
  go-tools
];
}