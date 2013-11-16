define gb::server::puma (
  $root = undef,
  $url  = undef,
  $port = 80,
  $ssl  = false,
) {

  file { "/etc/nginx/conf.d/${name}.conf":
    owner   => 'root',
    group   => 'root',
    mode    => 644,
    content => template('gb/nginx_with_puma.erb'),
    notify  => Service[nginx],
  }

  file { "/run/deploy/${name}":
    ensure  => directory,
    owner   => 'deploy',
    group   => 'deploy',
    mode    => 0644,
    require => File['/run/deploy'],
  }

}
