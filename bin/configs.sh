#!/bin/sh

# CONFIGS
# -----------------

# 1. DIRS
echo 'creating directories...'
mkdir ~/temp
mkdir ~/scripts
mkdir ~/code
mkdir ~/org
echo 'creating directories... done'

# 2. GIT
echo 'setting git name and email'
git config --global user.name "Sergio Uve"
git config --global user.email "sergiouve@gmail.com"
echo 'setting git name and email... done'

# ----------
source ~/.bashrc
# ----------

# 3. MISC
echo 'setting up oh my zsh...'
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
echo 'setting up oh my zsh... done'
