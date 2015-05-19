class gb::rcm {
  exec { 'rcm':
    cwd  => '/tmp',
    command => '/usr/bin/wget https://thoughtbot.github.io/rcm/debs/rcm_1.2.3-1_all.deb && \
                /usr/bin/dpkg -i rcm_1.2.3-1_all.deb',
  }
}
