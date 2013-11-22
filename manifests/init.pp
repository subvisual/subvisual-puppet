class gb (
  $ruby_version = undef,
) {
  # deploy user
  include gb::sudo
  gb::user { 'deploy': }
  gb::public_keys { 'deploy': }

  class { 'gb::ruby':
    version => $ruby_version,
  }

  class { 'gb::monit':
    ruby_version => $ruby_version,
  }

  # required packages
  include nginx
  include nodejs
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
}
