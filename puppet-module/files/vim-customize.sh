#!/usr/bin/env sh

export HOME=/home/$1

cd /tmp
wget https://github.com/scrooloose/nerdtree/archive/4.2.0.tar.gz
tar -xzf 4.2.0.tar.gz
mv nerdtree-4.2.0/* $HOME/.vim/
rm -r nerdtree-4.2.0
