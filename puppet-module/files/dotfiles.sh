#!/usr/bin/env sh

export HOME="/home/$1"
REPO="$HOME/.dotfiles"
RCRC="$HOME/.rcrc"

# install dotfiles repo
if [ -d $REPO ]; then
  cd $REPO && git pull
else
  git clone https://github.com/groupbuddies/dotfiles $HOME/.dotfiles
fi

cd $HOME && rcup -d $REPO -x README.md -x LICENSE -x Brewfile -x samples
