
curl -L https://nixos.org/nix/install | sh


nix run github:lnl7/nix-darwin#darwin-installer


echo "experimental-features = nix-command flakes" | sudo tee -a /etc/nix/nix.conf


git clone https://github.com/huuloc2026/nixos-config ~/dotfiles
cd ~/dotfiles


darwin-rebuild switch --flake ~/dotfiles#macbook
