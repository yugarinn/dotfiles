sudo dnf install jansson-devel autoconf make gcc texinfo glib2-devel gtk3-devel libgccjit-devel gnutls-devel ncurses-devel

git clone git://git.sv.gnu.org/emacs.git
cd emacs
git checkout tags/emacs-29.1 29.1

./autogen.sh
./configure --with-cairo --with-x-toolkit=no \
  --with-pgtk --with-modules --with-json --with-native-compilation \
  --prefix=/home/$(whoami)/local

make -j$(nproc)
make install
