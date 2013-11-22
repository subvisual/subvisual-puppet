define gb::user {
  group { 'deploy':
    ensure => present,
  }

  user { $name:
    ensure     => present,
    home       => "/home/$name",
    groups     => ['deploy'],
    shell      => '/bin/bash',
    managehome => true,
  }
}
