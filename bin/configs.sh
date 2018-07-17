#!/bin/sh

# CONFIGS
# -----------------

if [[ $(ps -A | egrep -i "gnome") ]]; then

  # 1 - TOP BAR BUTTONS
  echo '=> Changing window buttons layout...'
  gsettings set org.gnome.desktop.wm.preferences button-layout 'close:'
  echo '=> Done'

  # 2 - SET PLAY/PAUSE SHORTCUT
  echo 'Setting Play/Pause shortcut'
  gsettings set org.gnome.settings-daemon.plugins.media-keys play '<Shift>F9'
  echo '=> Done'

  # 3 - SET TERMINAL SHORTCUT
  echo '=> Setting Play/Pause shortcut'
  # gsettings set org.gnome.settings-daemon.plugins.media-keys play '<Shift>F9'
  echo '=> Done'

fi

# 4 - MKDIRS
echo '=> Creating directories I always end up using...'
cd
mkdir Temp
mkdir Scripts
mkdir Dev
mkdir Org
echo '=> Done'

# 5 - GIT GLOBAL
echo '=> Setting git name and email'
git config --global user.name "Sergio Uve"
git config --global user.email "sergiouve@gmail.com"
echo '=> Done'

# ----------
source ~/.bashrc
# ----------

# [XXX] - MUST BE DONE LAST SINCE OH MY ZSH DEFAULTS SYSTEM TO ZSH
# ZSH AND OH-MY-ZSH
echo '=> Installing zsh...'
sudo dnf install zsh -y
echo '=> Done'

echo '=> Installing Oh My Zsh!'
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
echo '=> Done'
