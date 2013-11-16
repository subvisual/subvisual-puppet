define gb::user {
  user { $name:
    ensure     => present,
    home       => "/home/$name",
    shell      => '/bin/bash',
    managehome => true,
  }
}
