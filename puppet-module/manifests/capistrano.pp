define gb::capistrano {
  file { [
      "/var/www/${name}/",
      "/var/www/${name}/shared",
      "/var/www/${name}/shared/sockets",
    ]:
    ensure => directory,
    owner  => 'deploy',
    group  => 'deploy',
    mode   => 0755,
  }

  file { "/var/www/${name}/shared/.env":
    ensure => present,
    owner  => 'deploy',
    group  => 'deploy',
    mode   => 0755,
    require => File["/var/www/${name}/shared"],
  }
}
