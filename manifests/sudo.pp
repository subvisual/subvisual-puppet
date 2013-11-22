class gb::sudo {
  include sudo

  sudo::conf { 'admins':
    priority => 11,
    content  => template('gb/sudoers.d/admin.erb')
  }

  sudo::conf { 'sudo':
    priority => 12,
    content  => template('gb/sudoers.d/sudo.erb')
  }

  sudo::conf { 'deploy':
    priority => 13,
    content  => template('gb/sudoers.d/deploy.erb'),
  }
}
