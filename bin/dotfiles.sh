#!/bin/sh

# DOTFILES
# -----------------

mkdir ~/.config/hypr
mkdir ~/.config/wofi

ln -s ~/.dotfiles/configs/hypr/hyprland.conf ~/.config/hypr/hyprland.conf
ln -s ~/.dotfiles/configs/hypr/waybar ~/.config/waybar
ln -s ~/.dotfiles/configs/hypr/hyprlock.conf ~/.config/hypr/hyprlock.conf

ln -s ~/.dotfiles/configs/doom ~/.config/doom
ln -s ~/.dotfiles/configs/alacritty ~/.config/alacritty
ln -s ~/.dotfiles/configs/tmux/tmux.conf ~/.tmux.conf
ln -s ~/.dotfiles/configs/hypr/wofi/style.css ~/.config/wofi/style.css
ln -s ~/.dotfiles/configs/mako ~/.config/mako
ln -s ~/.dotfiles/configs/profile ~/.profile
ln -s ~/.dotfiles/configs/zshrc ~/.zshrc
ln -s ~/.dotfiles/configs/vimrc ~/.vimrc
