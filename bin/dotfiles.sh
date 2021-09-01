#!/bin/sh

# DOTFILES
# -----------------

[[ -d ~/.doom.d ]] || mkdir doom.d
ln -s ~/.dotfiles/configs/doom.d/* ~/.doom.d
ln -s ~/.dotfiles/configs/profile ~/.profile
ln -s ~/.dotfiles/configs/zshrc ~/.zshrc
ln -s ~/.dotfiles/configs/tmux ~/.tmux.conf
ln -s ~/.dotfiles/configs/sway ~/.config/sway/config
ln -s ~/.dotfiles/configs/vimrc ~/.vimrc
