# packages-core.nix
{ pkgs, ... }: {
  nixpkgs.config.allowUnfree = true;

  home.packages = with pkgs; [

  #Languages
  rustc
  go
  typescript
  python3
  nodejs
  rust-analyzer
  go-tools
];
}