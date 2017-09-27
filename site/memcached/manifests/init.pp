class memcached {
  package { 'memcached':
    ensure => present,
  }

  file { '/etc/sysconfig/memcached':
    ensure => file,
    content => "PORT=\"1121\"\nUSER=\"memcached\"\nMAXCONN=\"96\"\nCACHESIZE=\"32\"\nOPTIONS=\"\"",
    require => Package['memcached'],
  }

  service { 'memcached':
    ensure => started,
    enable => true,
    subscribe => File['/etc/sysconfig/memcached'].
  }
}
