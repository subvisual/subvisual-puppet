define gb::user ($password) {
  group { 'deploy':
    ensure => present,
  }

  $password_hash = str2saltedsha512($password)

  # password hash can optionally begin with a $6$ to indicate libcrypt it's a SHA-512 hash
  user { $name:
    ensure     => present,
    home       => "/home/$name",
    password   => "$6$${password_hash}",
    groups     => ['deploy', 'sudo'],
    shell      => '/bin/bash',
    managehome => true,
  }
}
