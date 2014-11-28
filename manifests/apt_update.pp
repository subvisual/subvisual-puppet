class gb::apt_update {
  # apt-get update before main stage. required to install updated rvm dependencies
  # only runs if it has not updated in the last week
  stage { 'req-install':
    before => Stage['main'],
  }
  class requirements {
    exec { 'apt-update':
      command => '/usr/bin/apt-get -y update',
      onlyif  => "/bin/bash -c 'exit $(( $(( $(date +%s) - $(stat -c %Y /var/lib/apt/lists/$( ls /var/lib/apt/lists/ -tr1|tail -1  ))  )) >= 604800  ))'"
    }
  }
  class { requirements:
    stage => 'req-install',
  }
}
