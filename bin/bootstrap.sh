#!/bin/bash

sudo dnf upgrade -y

# Add third party repositories
sudo rpm -ivh http://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-38.noarch.rpm

# Insalling the basics
echo 'installing software...'
set -x \
    && sudo dnf upgrade \
    && sudo dnf install -y emacs tmux sway zsh

flatpak install flathub md.obsidian.Obsidian
