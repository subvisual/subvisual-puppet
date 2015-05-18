define gb::nginx_conf ($path) {
  $src = "/apps/${name}/current/${path}"
  $dst = "/etc/nginx/sites-enabled/${name}.conf"

  file { $dst:
    ensure => 'link',
    target => $src,
  }
}
