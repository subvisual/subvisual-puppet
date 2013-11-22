class gb::monit (
  $ruby_version = undef,
) {

  # create a wrapper for the bundle command
  rvm::define::wrapper { 'bundle':
    prefix       => 'monit',
    ruby_version => $ruby_version,
  }

  # install and start monit service
  package { 'monit':
    ensure => installed,
  }
  ->
  service { 'monit':
    ensure => running,
  }
}
