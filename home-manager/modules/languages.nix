# packages-core.nix
{ pkgs, ... }: {
  nixpkgs.config.allowUnfree = true;

  home.packages = with pkgs; [

  #Languages
  rustc
  go
  typescript
  # python3
  nodejs
  nodePackages.pnpm
  rust-analyzer
  go-tools
];
}