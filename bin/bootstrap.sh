#!/bin/bash

sudo dnf upgrade -y

# Add third party repositories
sudo rpm -ivh http://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-35.noarch.rpm
sudo dnf config-manager --add-repo=http://negativo17.org/repos/fedora-spotify.repo -y

# Insalling the basics
echo 'installing software...'
set -x \
    && sudo dnf upgrade \
    && sudo dnf install -y emacs tmux sway zsh vlc spotify-client steam

flatpak install flathub md.obsidian.Obsidian
