class gb {
  #include gb::sshd_config

  # deploy user
  gb::user { 'deploy': }
  gb::public_keys { 'deploy': }

  # required packages
  include nginx
  include nodejs
  include monit
  class { postgresql::server: }
  package { 'libpq-dev':
    ensure => installed,
  }

  # deploy directory
  file { '/var/www':
    ensure => directory,
    owner  => 'deploy',
    group  => 'deploy',
    mode   => 0755,
  }

  file { '/etc/nginx/conf.d/default.conf':
    ensure => absent,
  }

  # /var/run/deploy access
  file { '/run':
    ensure => present,
  }
  ->
  file { '/run/deploy':
    ensure => directory,
    owner  => 'deploy',
    group  => 'deploy',
    mode   => 0644,
  }

  monit::monitor { 'ssh':
    pidfile => '/var/run/sshd.pid',
  }
}
