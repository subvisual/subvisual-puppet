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
    ensure => present,
    mode   => 755,
    source => 'puppet:///modules/gb/vim-customize.sh',
  }

  exec { 'vim-customize':
    command => "/tmp/vim-customize.sh $name",
    require => [File['/tmp/vim-customize.sh'], File["/home/${name}/.vim"]],
    user    => $name,
    cwd     => "/home/$name",
  }
}
