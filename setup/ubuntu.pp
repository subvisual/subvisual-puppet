# base provisioning for a deploy machine

# deploy user
gb::user { 'deploy': }
gb::public_keys { 'deploy': }

# required packages
include gb::apt_update
include nginx

# upstart config
include gb::upstart

# deploy directory
file { '/var/www':
  ensure => directory,
  owner  => 'deploy',
  group  => 'deploy',
  mode   => 0755,
}

