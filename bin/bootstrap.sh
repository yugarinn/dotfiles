#!/bin/bash

sudo dnf upgrade -y

# Add third party repositories
sudo rpm -ivh http://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-38.noarch.rpm
sudo dnf copr enable solopasha/hyprland -y

dnf_packages=(
  alacritty
  hyprland
  mako
  pavucontrol
  swaybg
  tmux
  vim
  wayland
  zsh
)

flatpak_packages=(
  com.spotify.Client
  md.obsidian.Obsidian
  org.mozilla.Thunderbird
)

sudo dnf upgrade -y
sudo dnf install -y "${dnf_packages[@]}"

# Installing from Flathub
flatpak install flathub "${flatpak_packages[@]}" -y
