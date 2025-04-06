# languages.nix
{ config, pkgs, ... }:
{
  with pkgs; [
  rustc
  go
  typescript
  python3
  java
  nodejs
  ruby
  rust-analyzer
  go-tools
]
}