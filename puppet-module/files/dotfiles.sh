#!/usr/bin/env sh

REPO="$HOME/.dotfiles"
RCRC="$HOME/.rcrc"

# install dotfiles repo
if [ -d $REPO ]; then
  cd $REPO && git pull
else
  git clone https://github.com/groupbuddies/dotfiles ~/.dotfiles
fi

if [ -f $RCRC ]; then
  rcup
else
  rcup -d $REPO -x README.md -x LICENSE -x Brewfile -x samples
fi
