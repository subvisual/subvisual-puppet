class gb::upstart {
  file { '/etc/dbus-1/system.d/Upstart.conf':
    owner   => 'root',
    group   => 'root',
    mode    => 644,
    content => template('gb/Upstart.conf')
  }
}
