#!/bin/bash

git --version 2>&1 >/dev/null
GIT_IS_AVAILABLE=$?

if [ $GIT_IS_AVAILABLE -ne 0 ]; then
  echo 'installing git...'
  sudo dnf install git -y
  echo 'installing git... done'
fi

[[ -d ~/.dotfiles ]] || git clone --depth 1 https://github.com/yugarinn/dotfiles ~/.dotfiles

cd ~/.dotfiles || exit

PS3='Please enter your choice: '
options=("Setup dotfiles" "Setup config" "Install dependencies" "Quit")

select opt in "${options[@]}"
do
    case $opt in
        "Setup dotfiles and symlinks")
            echo "Setting up dotfiles and symlinks..."
            sleep 3
            ./bin/dotfiles.sh;
            ;;

        "Install software and update")
            echo "Installing and updating software..."
            sleep 3
            ./bin/bootstrap.sh;
            ;;
        "Setup system config")
            echo "Setting up system config..."
            sleep 3
            ./bin/configs.sh;
            ;;
        "Quit")
            echo "Now that's what I call a dead parrot."
            break
            ;;
        *) echo "invalid option $REPLY";;
    esac
done
