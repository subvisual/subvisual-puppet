define gb::capistrano {
  file { [
      "/apps/${name}/",
      "/apps/${name}/shared",
      "/apps/${name}/shared/sockets",
    ]:
    ensure => directory,
    owner  => 'deploy',
    group  => 'deploy',
    mode   => 0755,
  }

  file { "/apps/${name}/shared/.env":
    ensure => present,
    owner  => 'deploy',
    group  => 'deploy',
    mode   => 0755,
    require => File["/apps/${name}/shared"],
  }
}
