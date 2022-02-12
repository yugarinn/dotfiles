#!/bin/sh

# 1. UPDATE SYSTEM
# -----------------

sudo dnf update -y

# *. ADD RMPFUSION
sudo rpm -ivh http://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-32.noarch.rpm

# 1. INSTALL MISC SOFTWARE
# -----------------
#
echo 'installing software...'

# GIT
echo 'installing git...'
sudo dnf install git -y
echo 'installing git... done'

# EMACS
echo 'installing emacs...'
sudo dnf install emacs -y
git clone --depth 1 https://github.com/hlissner/doom-emacs ~/.emacs.d
~/.emacs.d/bin/doom install
echo 'installing emacs... done'

# NVM
echo 'installing nvm...'
curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.36.0/install.sh | bash
echo 'installing nvm... done'

# TMUX
echo 'installing tmux...'
sudo dnf install tmux -y
echo 'installing tmux... done'

# SWAY
echo 'installing sway...'
sudo dnf install sway -y
echo 'installing sway... done'

# ZSH
echo 'installing zsh...'
sudo dnf install zsh -y
echo 'installing zsh... done'

# 2. INSTALL MULTIMEDIA SOFTWARE
# -----------------

# SPOTIFY
echo 'installing spotify...'
sudo dnf config-manager --add-repo=http://negativo17.org/repos/fedora-spotify.repo -y
sudo dnf install spotify-client -y
echo 'installing spotify... done'

# VLC
echo 'installing vlc...'
sudo dnf install vlc -y
echo 'installing vlc... done'

# 3. BROWSERS
# -----------------

# FIREFOX
echo 'installing firefox...'
sudo dnf install vlc -y
echo 'installing firefox... done'

# GOOGLE CHROME
echo 'installing chrome...'
sudo cat << EOF > /etc/yum.repos.d/google-chrome.repo
[google-chrome]
name=google-chrome - \$basearch
baseurl=http://dl.google.com/linux/chrome/rpm/stable/\$basearch
enabled=1
gpgcheck=1
gpgkey=https://dl-ssl.google.com/linux/linux_signing_key.pub
EOF
sudo dnf install google-chrome-stable -y
echo 'installing chrome... done'
