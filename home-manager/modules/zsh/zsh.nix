{ config, pkgs, ... }:
let 
  myAliases = import ./aliases.nix;
in
{
  programs.zsh= {
    enable = true;
    shellAliases = myAliases; 
    promptInit = "source ${pkgs.zsh-powerlevel10k}/share/zsh-powerlevel10k/powerlevel10k.zsh-theme";
    plugins= [
        {
    name = "zsh-autosuggestions";
    src = pkgs.fetchFromGitHub {
      owner = "zsh-users";
      repo = "zsh-autosuggestions";
      rev = "v0.7.0";
      sha256 = "02p5wq93i12w41cw6b00hcgmkc8k80aqzcy51qfzi0armxig555y";
    };
  }
  {
    name = "zsh-syntax-highlighting";
    src = pkgs.fetchFromGitHub {
      owner = "zsh-users";
      repo = "zsh-syntax-highlighting";
      rev = "0.8.0";  
      sha256 = "1yl8zdip1z9inp280sfa5byjbf2vqh2iazsycar987khjsi5d5w8";
    };
  }
    ];
    oh-my-zsh.enable = true;
    oh-my-zsh.theme = "robbyrussell";
    oh-my-zsh.plugins = [ "git" 
    "node" 
    "docker" 
    ];
    history.size = 10000;
    initExtra = ''
      if [ -e "$HOME/.nix-profile/etc/profile.d/nix.sh" ]; then
        source "$HOME/.nix-profile/etc/profile.d/nix.sh"
      fi
      export PATH="$HOME/.nix-profile/bin:$PATH"
    '';
};
}