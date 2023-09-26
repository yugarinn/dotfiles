#!/bin/bash

echo 'creating directories...'
mkdir ~/Temp
mkdir ~/code
echo 'creating directories... done'

echo 'setting git name and email'
git config --global user.name "yugarinn"
git config --global user.email "yugarinn@proton.me"
echo 'setting git name and email... done'

echo 'setting up oh my zsh...'
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
echo 'setting up oh my zsh... done'

echo 'loading gnome configuration...'
dconf load / < ./configs/gnome-dconf-settings.ini
echo 'loading gnome configuration...'
