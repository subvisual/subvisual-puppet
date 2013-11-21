class gb::monit (
  $ruby_version = undef,
) {

  service { 'monit':
    ensure => running,
  }

  rvm::define::wrapper { 'bundle':
    prefix       => 'monit',
    ruby_version => $ruby_version,
  }
}
