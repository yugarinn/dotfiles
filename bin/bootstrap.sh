#!/bin/bash

sudo dnf upgrade -y

# Add third party repositories
sudo rpm -ivh http://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-38.noarch.rpm

# Installing the basics
echo 'installing software...'

set -x \
    && sudo dnf upgrade \
    && sudo dnf install -y tmux zsh mako pavucontrol

# Installing from Flathub
flatpak install flathub md.obsidian.Obsidian com.spotify.Client org.mozilla.Thunderbird -y

echo 'installing software... done'
