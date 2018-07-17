#!/bin/sh

# DOTFILES
# -----------------

mkdir ~/.emacs.d
ln -s ~/.dotfiles/configs/emacs.d/* ~/.emacs.d
ln -s ~/.dotfiles/configs/profile ~/.profile
ln -s ~/.dotfiles/configs/zshrc ~/.zshrc
ln -s ~/.dotfiles/configs/tmux ~/.tmux.conf
ln -s ~/.dotfiles/configs/sway ~/.config/sway/config
ln -s ~/.dotfiles/configs/vimrc ~/.vimrc
