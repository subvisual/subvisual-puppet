define gb::dotfiles {

  $home         = "/home/${name}"
  $scripts_path = "${home}/scripts/puppet"
  $script_name    = 'dotfiles.sh'
  $script         = "${scripts_path}/${script_name}"
  $script_src     = "puppet:///modules/gb/${script_name}"

  package { ['git', 'git-core']:
    ensure => installed,
    before => File[$script],
  }

  # defaults
  File {
    owner => $name,
    group => $name,
  }

  # install base scripts dir and ~/.ssh dir
  file { [ $home, "${home}/scripts", "${home}/scripts/puppet" ]:
    ensure => directory,
    before => File[$script],
  }

  # copy generate-authorized_keys.rb
  file { $script:
    ensure => present,
    mode   => 755,
    source => $script_src,
  }

  # generate authorized_keys
  exec { $script:
    command     => $script,
    refreshonly => true,
    require     => File[$script],
  }
}
