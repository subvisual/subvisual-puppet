define gb::rcm {
  exec { 'rcm':
    command => 'cd /tmp && \
                wget https://thoughtbot.github.io/rcm/debs/rcm_1.2.3-1_all.deb && \
                dpkg -i rcm_1.2.3-1_all.deb'
  }
}
