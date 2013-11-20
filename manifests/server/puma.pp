define gb::server::puma (
  $root = undef,
  $sockets_root = undef,
  $url  = undef,
  $port = 80,
  $ssl  = false,
  $env  = "production",
  $min_threads = 1,
  $max_threads = 2
) {

  file { "/etc/nginx/conf.d/${name}.conf":
    owner   => 'root',
    group   => 'root',
    mode    => 644,
    content => template('gb/nginx_with_puma.erb'),
    notify  => Service[nginx],
  }

  file { "${sockets_root}/puma_conf.rb":
    owner   => 'deploy',
    group   => 'deploy',
    mode    => 0644,
    content => template('gb/puma_conf.rb'),
  }
}
