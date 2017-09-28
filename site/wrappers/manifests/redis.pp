class wrappers::redis {
  class {'::redis':
    require => Class['::epel'],
  }
}
