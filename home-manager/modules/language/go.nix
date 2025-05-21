{ config,pkgs, ... }: {
  nixpkgs.config.allowUnfree = true;

  home.packages = with pkgs; [
    go            # Golang compiler
    sqlc          # Generate Go code from SQL
    gopls         # Language server (LSP) for VSCode/Neovim
    delve         # Debugger
    go-tools      # Static analysis, linters (staticcheck, etc.)
  ];
 
  home.sessionVariables = {
    GOPATH = "${config.home.homeDirectory}/go";
  };

  home.sessionPath = [
    "${config.home.homeDirectory}/go/bin"
  ];
}
