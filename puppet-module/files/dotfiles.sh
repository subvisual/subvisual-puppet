#!/usr/bin/env sh

REPO="$HOME/.dotfiles"
RCRC="$HOME/.rcrc"

# install dotfiles repo
if [ -d $REPO ]; then
  git clone git@github.com:groupbuddies:dotfiles ~/.dotfiles
else
  cd $REPO && git pull
fi

if [ -f $RCRC ]; then
  rcup
else
  rcup -d $REPO -x README.md -x LICENSE -x Brewfile -x samples
fi
