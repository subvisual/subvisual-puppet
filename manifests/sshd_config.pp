class gb::sshd_config {

  file { '/etc/ssh/sshd_config':
    owner   => 'root',
    group   => 'root',
    mode    => 444,
    content => template('gb/sshd_config.erb'),
    notify  => Service[ssh],
  }

  service { ssh:
    ensure => running,
  }
}
