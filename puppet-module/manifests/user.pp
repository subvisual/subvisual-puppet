define gb::user (
  $password_hash = undef,
) {
  group { 'deploy':
    ensure => present,
  }

  # password hash can optionally begin with a $6$ to indicate libcrypt it's a SHA-512 hash
  user { $name:
    ensure     => present,
    home       => "/home/$name",
    groups     => ['deploy', 'sudo'],
    shell      => "/bin/bash",
    managehome => true,
  }
}
