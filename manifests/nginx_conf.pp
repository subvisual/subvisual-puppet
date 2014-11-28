define gb::nginx_conf ($path) {
  $src = "/var/www/${name}/current/${path}"
  $dst = "/etc/nginx/sites-enabled/${name}.conf"

  file { $dst:
    ensure => 'link',
    target => $src,
  }
}
