class gb::monit {
  service { 'monit':
    ensure => running,
  }

  rvm::define::wrapper { 'bundle':
    prefix => 'monit',
  }
}
