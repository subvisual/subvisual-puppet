class gb::rvm_install ($ruby_version=undef, $rvm_version=undef) {

  stage { 'req-install':
    before => Stage['rvm-install'],
  }

  class requirements {
    exec { 'apt-update':
      command => '/usr/bin/apt-get -y update',
    }
  }

  class { requirements:
    stage => 'req-install',
  }

  class { rvm:
    version => $rvm_version,
  }

  rvm::system_user { 'deploy': }

  rvm_system_ruby { $ruby_version:
    ensure      => present,
    default_use => true,
  }

  rvm_gem {
    'bundler':
      ruby_version => $ruby_version,
      ensure       => present,
      require      => Rvm_system_ruby[$ruby_version];
    'puppet':
      ruby_version => $ruby_version,
      ensure       => present,
      require      => Rvm_system_ruby[$ruby_version];
  }

  file { '/etc/puppet/hiera.yaml':
    ensure => present,
  }

}
