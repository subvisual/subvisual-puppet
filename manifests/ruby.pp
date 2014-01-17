class gb::ruby ($version=undef) {

  # install rvm
  include rvm

  # apt-get update before main stage. required to install updated rvm dependencies
  stage { 'req-install':
    before => Stage['main'],
  }
  class requirements {
    exec { 'apt-update':
      command => '/usr/bin/apt-get -y update',
    }
  }
  class { requirements:
    stage => 'req-install',
  }

  package { ['imagemagick', 'libmagickcore-dev', 'libmagickwand-dev']:
    ensure => installed
  }

  # deploy user must belong to the rvm group
  group { 'rvm':
    ensure => present,
  }
  rvm::define::user { 'deploy': }

  # install specified ruby version
  rvm::define::version { $version:
    ensure => present,
    system => 'true',
  }

  # install bundler and puppet
  rvm::define::gem {
    'bundler':
      ensure       => present,
      ruby_version => $version;
  }

}
