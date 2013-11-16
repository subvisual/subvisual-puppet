define gb::public_keys {
  include git

  $home = "/home/${name}"
  $scripts_path = "${home}/scripts/puppet"
  $repo_path = "${scripts_path}/public-keys"

  $script_name = 'generate-authorized_keys.rb'
  $script = "${scripts_path}/${script_name}"
  $script_src = "puppet:///modules/gb/${script_name}"
  $auth_keys_file = "/home/${name}/.ssh/authorized_keys"

  file { [ $home, "${home}/scripts", "${home}/scripts/puppet", "${home}/.ssh"]:
    ensure => directory,
    owner  => $name,
    group  => $name,
    before => File[$script],
  }

  file { $script:
    ensure => present,
    mode   => 755,
    source => $script_src,
    owner  => $name,
    group  => $name,
  }

  git::repo { $repo_path:
    path    => $repo_path,
    source  => 'git://github.com/groupbuddies/public-keys.git',
    branch  => 'master',
    update  => true,
    require => User[$name],
    notify  => Exec[$script],
  }

  exec { $script:
    command     => "${script} ${repo_path} ${name}",
    refreshonly => true,
    require     => File[$script],
    notify      => File[$auth_keys_file],
  }

  file { $auth_keys_file:
    ensure => file,
    owner  => $name,
    group  => $name,
    mode   => 644,
  }
}
