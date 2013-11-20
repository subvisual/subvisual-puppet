define gb::app::rails (
  $rails_env = 'production',
  $db_pass   = undef,
  $server    = 'puma',
  $url       = undef,
  $port      = 80,
  $ssl       = false,
  $min_threads = 1,
  $max_threads = 2,
) {

  $capistrano_root = "/var/www/${name}"
  $db_yml = "${capistrano_root}/shared/config/database.yml"

  # database role
  postgresql::server::role { $name:
    password_hash => postgresql_password($name, $db_pass),
  }
  # database user
  postgresql::server::db { $name:
    user     => $name,
    password => postgresql_password($name, $db_pass),
  }

  # shared/config/database.yml
  file { [$capistrano_root, "${capistrano_root}/shared", "${capistrano_root}/shared/config", "${capistrano_root}/shared/sockets" ]:
    ensure => directory,
    owner  => 'deploy',
    group  => 'deploy',
  }
  ->
  file { $db_yml:
    owner   => 'deploy',
    group   => 'deploy',
    content => template('gb/database.yml.erb'),
    notify  => Service[nginx],
  }

  # web server
  case $server {
    puma: { gb::server::puma { $name:
        root         => "${capistrano_root}/current/public",
        sockets_root => "${capistrano_root}/shared/sockets",
        port         => $port,
        url          => $url,
        env          => $rails_env,
        min_threads  => $min_threads,
        max_threads  => $max_threads,
        require      => File["${capistrano_root}/shared/sockets"]
      }
    }

    undef:   { notice("No server defined for app ${name}") }
    default: { fail("Server ${server} not supported") }
  }
}
