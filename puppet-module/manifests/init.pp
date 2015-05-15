class gb {
  package { ['vim', 'htop', 'zsh']:
    ensure => installed,
  }
}
