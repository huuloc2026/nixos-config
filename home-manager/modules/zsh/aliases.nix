let
  myAliases = {
    # Basic commands
    c = "clear";             # Clear screen
    ll = "ls -l";            # List files with detailed info
    la = "ls -la";           # List all files, including hidden files
    ".." = "cd ..";            # Go up one directory
    "...." = "cd ../../";       # Go up two directories
    #cat = "bat";
    gh = "cd ~/ && clear && echo '🦥 Went back home - Jake Onyx' ";           # Go to home directory
    grep = "grep --color=auto"; # Enable color in grep outputs
    rm = "rm -i";            # Make `rm` interactive (ask for confirmation)

    vi = "nvim";
    # Home Manager alias switch
    gopro = "cd ~/nixos-config  && clear && echo 'in Nixos-Config 👨‍💻'";
    cfneovim = "cd ~/nixos-config/home-manager/modules/nvim && clear && echo 'In config neovim space 💤💤💤'";
    swhm = "cd ~/nixos-config && home-manager switch --flake .#jakeonyx"; #alias switch Home Mangaer
    # NixOS alias switch
    syssw = "sudo nixos-rebuild switch";  # Switch system configuration for NixOS
  
    # Docker commands
    dcu = "docker compose up -d";        # Docker Compose: start containers in detached mode
    dcd = "docker compose down";         # Docker Compose: stop and remove containers
    dcps = "docker compose ps";          # Docker Compose: list running containers


    #Personal Shortcut
    mg="brave 'https://github.com/huuloc2026?tab=repositories'";

    # # Git aliases
    # gs = "git status";       # Check the status of the Git repository
    # ga = "git add";          # Add files to staging area
    # gaa = "git add .";       # Add all files to staging area
    # gc = "git commit -m";    # Commit changes with a message
    # gco = "git checkout";    # Checkout branch
    # gl = "git log --oneline";# Show commit history in a single line format
    # gd = "git diff";         # Show differences between files
    # gpl = "git pull";        # Pull the latest changes from remote
    # gps = "git push";        # Push local changes to remote
  };
in
  myAliases
