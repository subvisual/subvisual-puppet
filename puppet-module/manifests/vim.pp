define gb::vim {
  package { 'vim':
    ensure => installed,
  }

  file { "/home/${name}/.vim":
    ensure => directory,
    owner => $name,
    group => $name,
  }

  file { '/tmp/vim-customize.sh':
    source => 'puppet:///modules/gb/vim-customize.sh',
  }

  exec { 'vim-customize':
    command => '/tmp/vim-customize.sh',
    require => [File['/tmp/vim-customize.sh'], File["home/${name}/.vim"]],
    user    => $name,
    cwd     => "home/$name",
  }
}
