sudo dnf install -y jansson-devel autoconf make gcc texinfo glib2-devel gtk3-devel libgccjit-devel gnutls-devel ncurses-devel

git clone git://git.sv.gnu.org/emacs.git
cd emacs
git checkout tags/emacs-30.1

./autogen.sh
./configure --with-cairo --with-x-toolkit=no \
  --with-pgtk --with-modules --with-json --with-native-compilation \
  --prefix=/usr/local

make -j$(nproc)
sudo make install

cd -
rm -rf emacs

# Doom
git clone --depth 1 https://github.com/doomemacs/doomemacs ~/.config/emacs
~/.config/emacs/bin/doom install
