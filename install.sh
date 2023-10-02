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
options=("Do all" "Setup dotfiles" "Setup config" "Install dependencies" "Quit")

while true; do
  clear
  echo "Please choose an option:"
  select opt in "${options[@]}"; do
      case $opt in
          "Do all")
              ./bin/dotfiles.sh;
              ./bin/bootstrap.sh;
              ./bin/configs.sh;
              ./bin/emacs.sh;
              echo "Done!"
              break
              ;;
          "Setup dotfiles")
              ./bin/dotfiles.sh;
              echo "Done!"
              break
              ;;
          "Install dependencies")
              ./bin/bootstrap.sh;
              echo "Done!"
              break
              ;;
          "Setup config")
              ./bin/configs.sh;
              echo "Done!"
              break
              ;;
          "Setup emacs")
              ./bin/emacs.sh;
              echo "Done!"
              break
              ;;
          "Quit")
              chsh -s $(which zsh)
              echo "Now that's what I call a dead parrot."
              exit
              ;;
          *) echo "Invalid option: $REPLY"; break;;
      esac
  done
done
