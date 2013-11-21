define gb::app::rails (
  $rails_env = 'production',
  $db_pass   = undef,
  $url       = undef,
  $port      = 80,
  $ssl       = false,
  $min_threads = 1,
  $max_threads = 2,
) {

  #
  # VARS
  #
  $capistrano_root = "/var/www/${name}"
  $app_root        = "${capistrano_root}/current"
  $shared_root     = "${capistrano_root}/shared"
  $public_root     = "${capistrano_root}/current/public"
  $sockets_root    = "${capistrano_root}/shared/sockets"
  $config_root     = "${capistrano_root}/shared/config"

  $nginx_conf    = "/etc/nginx/conf.d/${name}.conf"
  $pidfile       = "${sockets_root}/puma.pid"
  $puma_conf     = "${sockets_root}/puma_conf.rb"
  $puma_state    = "${sockets_root}/puma.state"
  $monit_name    = "${name}-puma"
  $start_command = "cd ${app_root} && bundle exec puma -C ${puma_conf}"
  $stop_command  = "cd ${app_root} && bundle_exec pumactl -S ${puma_state} stop"

  $db_yml = "${capistrano_root}/shared/config/database.yml"

  #
  # DATABASE
  #
  # database role
  postgresql::server::role { $name:
    password_hash => postgresql_password($name, $db_pass),
  }
  # database user
  postgresql::server::db { $name:
    user     => $name,
    password => postgresql_password($name, $db_pass),
  }

  #
  # DATABASE.YML
  #
  # shared/config/database.yml
  file { [$capistrano_root, $shared_root, $config_root, $sockets_root]:
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

  #
  # NGINX
  #
  file { $nginx_conf:
    owner   => 'root',
    group   => 'root',
    mode    => 0644,
    content => template('gb/nginx_with_puma.erb'),
    notify  => Service[nginx],
  }

  #
  # PUMA
  #
  file { $puma_conf:
    owner   => 'deploy',
    group   => 'deploy',
    mode    => 0644,
    content => template('gb/puma_conf.rb'),
  }

  file { "/etc/monit/conf.d/${monit_name}.conf":
    content => template('gb/monit.conf.erb'),
  }
}
