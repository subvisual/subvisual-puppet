class gb::base {
  $home = "/home/${name}"

  package { ['htop', 'zsh', 'git', 'git-core']:
    ensure => installed,
  }

  # install base scripts dir and ~/.ssh dir
  file { [ $home, "${home}/scripts", "${home}/scripts/puppet", "${home}/.ssh"]:
    ensure => directory,
    owner  => $name,
    group  => $name,
  }

  file{ '/apps':
    ensure => directory,
    owner  => $name,
    group  => $name,
    mode   => 0755,
  }

  include gb::apt_update
  include nginx
  include gb::upstart

  gb::user        { "${name}": }
  gb::public_keys { "${name}": }
  gb::dotfiles    { "${name}": }
  gb::vim         { "${name}": }
}
