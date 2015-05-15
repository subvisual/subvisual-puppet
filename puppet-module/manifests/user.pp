define gb::user (
  $password_hash = undef,
  $shell = "zsh",
) {
  group { 'deploy':
    ensure => present,
  }

  package { $shell:
    ensure => installed,
  }

  # password hash can optionally begin with a $6$ to indicate libcrypt it's a SHA-512 hash
  user { $name:
    ensure     => present,
    home       => "/home/$name",
    groups     => ['deploy', 'sudo'],
    shell      => "/bin/$shell",
    managehome => true,
  }
}
