class gb (
  $ruby_version = undef,
  $deploy_password = undef,
) {

  include gb::apt_update
  # deploy user
  /* include gb::sudoers */

  gb::user { 'deploy':
    password => $deploy_password,
  }
  gb::public_keys { 'deploy': }

  /* class { 'gb::ruby': */
  /*   version => $ruby_version, */
  /* } */

  /* class { 'gb::monit': */
  /*   ruby_version => $ruby_version, */
  /* } */

  # required packages
  include nginx
  include nodejs
  class { postgresql::server: }
  package { 'libpq-dev':
    ensure => installed,
  }

  /* # deploy directory */
  file { '/var/www':
    ensure => directory,
    owner  => 'deploy',
    group  => 'deploy',
    mode   => 0755,
  }
}
