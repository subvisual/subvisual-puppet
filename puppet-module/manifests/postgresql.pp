define gb::postgresql (
  $password,
) {

  include postgresql::server
  ensure_packages(['libpq-dev'])

  postgresql::server::role { $name:
    password_hash => postgresql_password($name, $password)
  }

  postgresql::server::db { $name:
    user     => $name,
    password => postgresql_password($name, $password)
  }
}
