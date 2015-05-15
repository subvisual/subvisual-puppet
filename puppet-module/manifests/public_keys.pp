define gb::public_keys {

  $home         = "/home/${name}"
  $scripts_path = "${home}/scripts/puppet"
  $repo_path    = "${scripts_path}/public-keys"
  $repo_url     = 'git://github.com/groupbuddies/public-keys.git'

  $script_name    = 'generate-authorized_keys.rb'
  $script         = "${scripts_path}/${script_name}"
  $script_src     = "puppet:///modules/gb/${script_name}"
  $auth_keys_file = "/home/${name}/.ssh/authorized_keys"

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
    require => File[$scripts_path],
  }

  # clone public-keys repo
  vcsrepo { $repo_path:
    ensure    => present,
    provider  => git,
    source    => $repo_url,
    revision  => 'master',
    notify    => Exec[$script],
    require   => Package['git'],
  }

  # generate authorized_keys
  exec { $script:
    command     => "${script} ${repo_path} ${name}",
    refreshonly => true,
    require     => File[$script],
    notify      => File[$auth_keys_file],
  }

  # ensure file mode
  file { $auth_keys_file:
    ensure => file,
    mode   => 644,
  }
}
