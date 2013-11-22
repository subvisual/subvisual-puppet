define gb::user ($password) {
  group { 'deploy':
    ensure => present,
  }

  user { $name:
    ensure     => present,
    home       => "/home/$name",
    password   => sha1($password),
    groups     => ['deploy', 'sudo'],
    shell      => '/bin/bash',
    managehome => true,
  }
}
