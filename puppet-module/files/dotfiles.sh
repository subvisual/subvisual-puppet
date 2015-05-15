#!/usr/bin/env sh

function download_rcm {
  wget https://thoughtbot.github.io/rcm/debs/rcm_1.2.3-1_all.deb -O /tmp/rcm.deb
  dpkg -i /tmp/rcm.deb
}

REPO="$HOME/.dotfiles"
RCRC="$HOME/.rcrc"

# install rcm if necessary
$(which rcup)   || download_rcm

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
