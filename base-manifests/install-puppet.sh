#!/usr/bin/env bash

apt-get install --yes lsb_release
DISTRIB_CODENAME=$(lsb_release --codename --short)
DEB="puppetlabs-release-${DISTRIB_CODENAME}.deb"
DEB_PROVIDES="/etc/apt/sources.list.d/puppetlabs.list" # Assume that this file's existence means we have Puppet Labs repo added

if [ ! -e $DEB_PROVIDES ]
then
  wget -q http://apt.puppetlabs.com/$DEB
  sudo dpkg -i $DEB
fi

sudo apt-get update
sudo apt-get install --yes puppet
puppet module install groupbuddies-gb --force --version 0.1.3
