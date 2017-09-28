class wrappers::redis {
  class {'::redis':
    require => '::epel',
  }
}
