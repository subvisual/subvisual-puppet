class gb::ruby ($version=undef) {

  include rvm

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

  group { 'rvm':
    ensure => present,
  }

  #rvm::system_user { 'deploy': }
  rvm::define::user { 'deploy': }

  rvm::define::version { $version:
    ensure => present,
    system => true,
  }
  #rvm_system_ruby { $version:
    #ensure      => present,
    #default_use => true,
  #}

  #rvm_gem {
    #'bundler':
      #version => $version,
      #ensure       => present,
      #require      => Rvm_system_ruby[$version];
    #'puppet':
      #version => $version,
      #ensure       => present,
      #require      => Rvm_system_ruby[$version];
  #}

  rvm::define::gem {
    'bundler':
      ensure       => present,
      ruby_version => $version;
    'puppet':
      ensure       => present,
      ruby_version => $version;
  }

  file { '/etc/puppet/hiera.yaml':
    ensure => present,
  }

}
