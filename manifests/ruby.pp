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

  # deploy user must belong to the rvm group
  group { 'rvm':
    ensure => present,
  }
  #rvm::system_user { deploy: }
  rvm::define::user { 'deploy': }

  # install specified ruby version
  rvm::define::version { $version:
    ensure => present,
    system => 'true',
  }
  #rvm_system_ruby { $version:
    #ensure      => present,
    #default_use => true,
  #}

  # install bundler and puppet
  rvm::define::gem {
    'bundler':
      ensure       => present,
      ruby_version => $version;
    'puppet':
      ensure       => present,
      ruby_version => $version;
  }

  # unused file, but required to prevent error
  file { '/etc/puppet/hiera.yaml':
    ensure => present,
  }

}
