#!/usr/bin/env zsh

echo "Enter the repository name you want to clone:"
read input
username="huuloc2026"

clone_repo() { 
    local repo_name="$1"
    local user="$2"  
    local REPO_URL="git@github.com:${user}/${repo_name}.git"

    git clone "$REPO_URL" ~/"${repo_name}"

    if [ $? -eq 0 ]; then
        echo "Repository cloned successfully!"
    else
        echo "An error occurred while cloning the repository."
    fi
}

copy_repo() {
    if [[ -d ~/"$input" && -f ~/"$input"/Passwords.kdbx ]]; then
        cp ~/"$input"/Passwords.kdbx ~/.
        echo "Passwords.kdbx copied to home directory."
    else
        echo "Passwords.kdbx not found in cloned repository."
    fi
}

gen_that() {
    if [[ -d ~/"$input" && -f ~/"$input"/generatepassword.py ]]; then
         cd ~/"$input"/
         python3 ~/"$input"/generatepassword.py
    else
        echo "generatepassword.py not found in cloned repository."
    fi
}

clone_repo "$input" "$username"
copy_repo 
gen_that 