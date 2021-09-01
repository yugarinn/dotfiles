#!/bin/bash

git --version 2>&1 >/dev/null
GIT_IS_AVAILABLE=$?

if [ $GIT_IS_AVAILABLE -ne 0 ]; then
  echo 'installing git...'
  sudo dnf install git -y
  echo 'installing git... done'
fi

[[ -d ~/.dotfiles ]] || git clone --depth 1 https://github.com/sergiouve/dotfiles ~/.dotfiles

PS3='Please enter your choice: '
options=("Install software and update" "Setup system config" "Setup dotfiles and symlinks" "Quit")

select opt in "${options[@]}"
do
    case $opt in
        "Option 1")
            echo "Installing and updating software..."
            sleep 3
            ~/.dotfiles/bin/bootstrap.sh;
            ;;
        "Option 2")
            echo "Setting up system config..."
            sleep 3
            ~/.dotfiles/bin/configs.sh;
            ;;
        "Option 3")
            echo "Setting up dotfiles and symlinks..."
            sleep 3
            ~/.dotfiles/bin/dotfiles.sh;
            ;;
        "Quit")
            echo "Now that's what I call a dead parrot."
            break
            ;;
        *) echo "invalid option $REPLY";;
    esac
done
