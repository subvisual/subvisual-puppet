define gb::ruby {

  include nodejs

  package { ['imagemagick', 'libmagickcore-dev', 'libmagickwand-dev']:
    ensure => installed
  }

  file { '/etc/gemrc':
    content => 'gem: --no-document',
    before  => Rvm_gem['bundler'],
  }

  # install rvm
  include rvm
  rvm::system_user { deploy: }

  rvm_system_ruby { $name:
    ensure      => present,
    default_use => true,
  }

  rvm_gem {
    'bundler':
      name         => 'bundler',
      ensure       => latest,
      ruby_version => $name,
      require      => Rvm_system_ruby[$name],
  }

}
