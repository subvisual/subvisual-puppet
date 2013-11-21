class gb::rvm_install ($ruby_version=undef, $rvm_version=undef) {

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

  rvm::define::version { $ruby_version:
    ensure => present,
    system => true,
  }
  #rvm_system_ruby { $ruby_version:
    #ensure      => present,
    #default_use => true,
  #}

  #rvm_gem {
    #'bundler':
      #ruby_version => $ruby_version,
      #ensure       => present,
      #require      => Rvm_system_ruby[$ruby_version];
    #'puppet':
      #ruby_version => $ruby_version,
      #ensure       => present,
      #require      => Rvm_system_ruby[$ruby_version];
  #}

  rvm::define::gem {
    'bundler':
      ensure       => present,
      ruby_version => $ruby_version;
    'puppet':
      ensure       => present,
      ruby_version => $ruby_version;
  }

  file { '/etc/puppet/hiera.yaml':
    ensure => present,
  }

}
