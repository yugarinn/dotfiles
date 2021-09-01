#!/bin/bash

git --version 2>&1 >/dev/null
GIT_IS_AVAILABLE=$?

if [ $GIT_IS_AVAILABLE -eq 0 ]; then
  echo 'installing git...'
  sudo dnf install git -y
  echo 'installing git... done'
fi

git clone --depth 1 https://github.com/sergiouve/dotfiles ~/.dotfiles

while true; do
  read -p "Install software and update? (y/n) " yn
  case $yn in
    [Yy]* ) ~/.dotfiles/bin/bootstrap.sh; break;;
    [Nn]* ) break;;
    * ) echo "C'mon you can do this";;
  esac
done

# Config
while true; do
  read -p "Setup system configs? (y/n) " yn
  case $yn in
    [Yy]* ) ~/.dotfiles/bin/configs.sh; break;;
    [Nn]* ) break;;
    * ) echo "C'mon you can do this";;
  esac
done

# Dotfiles
while true; do
  read -p "Setup dotfiles? (y/n) " yn
  case $yn in
    [Yy]* ) ~/.dotfiles/bin/dotfiles.sh; break;;
    [Nn]* ) break;;
    * ) echo "C'mon you can do this";;
  esac
done

echo "Now that's what I call a dead parrot."
