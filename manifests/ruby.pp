class gb::ruby ($version=undef) {

  package { ['imagemagick', 'libmagickcore-dev', 'libmagickwand-dev']:
    ensure => installed
  }

  # install rvm
  include rvm
  rvm::system_user { deploy: }

  rvm_system_ruby { $version:
    ensure      => present,
    default_use => true,
  }

  rvm_gem {
    'bundler':
      ensure       => present,
      ruby_version => $version,
      require      => Rvm_system_ruby[$version],
  }

}
