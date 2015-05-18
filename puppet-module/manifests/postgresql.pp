define gb::postgresql (
  $password,
  $version = '9.4',
) {

  class { 'postgresql::globals':
    manage_package_repo => true,
    version             => $version,
  } ->
  class { 'postgresql::server': }

  ensure_packages(['libpq-dev'])

  postgresql::server::role { $name:
    password_hash => postgresql_password($name, $password)
  }

  postgresql::server::db { $name:
    user     => $name,
    password => postgresql_password($name, $password)
  }
}
