#!/bin/bash

# Directories
echo 'creating directories...'
mkdir ~/Temp
mkdir ~/code
echo 'creating directories... done'

# Git user
echo 'setting git name and email'
git config --global user.name "yugarinn"
git config --global user.email "yugarinn@proton.me"
echo 'setting git name and email... done'

# oh-my-zsh
echo 'setting up oh my zsh...'
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
echo 'setting up oh my zsh... done'

# Gnome
dconf load / < ./configs/gnome-dconf-settings.ini
