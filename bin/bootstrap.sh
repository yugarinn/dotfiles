#!/bin/sh

# 1. UPDATE SYSTEM
# -----------------

sudo dnf update -y

# *. ADD RMPFUSION
sudo rpm -ivh http://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-25.noarch.rpm

# 2. INSTALL DEV SOFTWARE
# -----------------

# EMACS
echo '=>Installing Emacs'
sudo dnf install emacs -y
echo '=>Done'

# ATOM
echo '=> Installign Atom...'
ATOM_LATEST_VERSION=$(wget -q "https://api.github.com/repos/atom/atom/releases/latest"  -O - | grep -E "https.*atom-amd64.tar.gz" | cut -d '"' -f 4 | cut -d '/' -f 8 | sed 's/v//g')

wget -c https://github.com/atom/atom/releases/download/v${ATOM_LATEST_VERSION}/atom.x86_64.rpm -O /tmp/atom.x86_64.rpm
sudo dnf install /tmp/atom.x86_64.rpm -y --nogpgcheck
rm /tmp/atom.x86_64.rpm
echo '=> Done'

# FILEZILLA
echo '=> Installing Filezilla'
sudo dnf install filezilla -y
echo '=> Done'

# VIRTUALBOX
echo '=> Installing VirtualBox-5.1'
sudo dnf install binutils qt gcc make patch libgomp glibc-headers glibc-devel kernel-headers kernel-devel dkms -y
cd /etc/yum.repos.d/
sudo wget http://download.virtualbox.org/virtualbox/rpm/fedora/virtualbox.repo
sudo dnf install VirtualBox-5.1 -y
echo '=> Done'

# VAGRANT
echo '=> Installing Vagrant...'
sudo dnf install vagrant -y
echo '=> Done'

# YODO
echo '=> Installing yodo...'
sh -c "$(curl -fsSL https://raw.githubusercontent.com/sergiouve/yoDo/master/tools/install.sh)"
echo '=> Done'

# NVM
echo '=> Installing nvm'
curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.33.2/install.sh | bash
echo '=> Done'

# TMUX
echo '=> Installing tmux'
sudo dnf install tmux -y
echo '=> Done'

# TMUXINATOR
echo '=> Installing tmuxinator'
sudo dnf install tmuxinator -y
echo '=> Done'

# 3. INSTALL MULTIMEDIA SOFTWARE
# -----------------

# SPOTIFY
echo '=> Installing Spotify...'
sudo dnf config-manager --add-repo=http://negativo17.org/repos/fedora-spotify.repo -y
sudo dnf install spotify-client -y
echo '=> Done'

# VLC
echo '=> Installing VLC...'
sudo dnf install vlc -y
echo '=> Done'

# 4. MISC
# -----------------

# # FILELIGHT
# echo '=> Installing Filelight...'
# sudo dnf install filelight -y
# echo '=> Done'
#
# # GPARTED
# echo '=> Installing gParted...'
# sudo dnf install gparted -y
# echo '=> Done'
#
# # UNETBOOTIN
# echo '=> Installing Unetbootin...'
# sudo dnf install unetbootin -y
# echo '=> Done'
#
# # SYNAPSE
# echo '=> Installing Synapse...'
# sudo dnf install synapse -y
# echo '=> Done'

# SHELL THEME (ARC)
echo '=> Installing Arc theme...'
sudo dnf install arc-theme -y
echo '=> Done'

# MOKA & FABA ICONS
echo '=> Installing Moka/Faba icons'
sudo dnf config-manager --add-repo http://download.opensuse.org/repositories/home:snwh:moka/Fedora_25/home:snwh:moka.repo -y
sudo dnf install moka-icon-theme -y
sudo dnf install faba-icon-theme -y
echo '=> Done'

# GNOME TWEAK TOOL
echo '=> Installing Moka/Faba icons'
sudo dnf install gnome-tweak-tool -y
echo '=> Done'

# 6. BROWSERS
# -----------------

# FIREFOX DEVELOPER EDITION
# echo '=> Installing Firefox Developer Edition'
# curl -L http://git.io/firefoxdev | sh
# echo '=> Done.'

# GOOGLE CHROME
echo '=> Installing Google Chrome'

sudo cat << EOF > /etc/yum.repos.d/google-chrome.repo
[google-chrome]
name=google-chrome - \$basearch
baseurl=http://dl.google.com/linux/chrome/rpm/stable/\$basearch
enabled=1
gpgcheck=1
gpgkey=https://dl-ssl.google.com/linux/linux_signing_key.pub
EOF

sudo dnf install google-chrome-stable -y

echo '=> Done'
