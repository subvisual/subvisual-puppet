class gb::monit (
  $ruby_version = undef,
) {

  # install and start monit service
  package { 'monit':
    ensure => installed,
  }

  service { 'monit':
    ensure  => running,
    require => Package['monit'],
  }
}

