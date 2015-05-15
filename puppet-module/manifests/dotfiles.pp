define gb::dotfiles {

  $home         = "/home/${name}"
  $scripts_path = "${home}/scripts/puppet"
  $script_name    = 'dotfiles.sh'
  $script         = "${scripts_path}/${script_name}"
  $script_src     = "puppet:///modules/gb/${script_name}"

  # defaults
  File {
    owner => $name,
    group => $name,
  }

  # copy generate-authorized_keys.rb
  file { $script:
    ensure  => present,
    mode    => 755,
    source  => $script_src,
    require => [Package['git'], File[$scripts_path]],
  }

  # generate authorized_keys
  exec { $script:
    command     => $script,
    refreshonly => true,
    require     => File[$script],
  }
}
