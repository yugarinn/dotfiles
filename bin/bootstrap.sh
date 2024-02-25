#!/bin/bash

sudo dnf upgrade -y

# Add third party repositories
sudo rpm -ivh http://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-38.noarch.rpm
sudo dnf copr enable solopasha/hyprland -y

dnf_packages=(
  alacritty
  grimshot
  hyprland
  mako
  pavucontrol
  steam
  swaybg
  tmux
  util-linux-user
  vim
  vlc
  waybar
  wtype
  zsh
)

flatpak_packages=(
  com.discordapp.Discord
  com.spotify.Client
  md.obsidian.Obsidian
  org.gnome.Extensions
  org.mozilla.Thunderbird
  io.dbeaver.DBeaverCommunity
)

sudo dnf upgrade -y
sudo dnf install -y "${dnf_packages[@]}"

# Installing from Flathub
flatpak install flathub "${flatpak_packages[@]}" -y

# Installing Gnome Extensions
rm -f ./install-gnome-extensions.sh; wget -N -q "https://raw.githubusercontent.com/ToasterUwU/install-gnome-extensions/master/install-gnome-extensions.sh" -O ./install-gnome-extensions.sh && chmod +x install-gnome-extensions.sh
./install-gnome-extensions.sh --enable 277 517 3193 1460 2890 973 # impatience, caffeine, blur-my-shell, vitals, tray-icons-reloaded, switcher
rm -f ./install-gnome-extensions.sh
