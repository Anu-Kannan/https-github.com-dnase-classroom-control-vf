class memcached {
  package { 'memcached':
    ensure => present, 
  }
  
  service { 'memcached':
    ensure => running,
    subscribe => File['/etc/sysconfig/memcached'],
  }
  
  file { '/etc/sysconfig/memcached':
     ensure => file,
     content => "PORT='11211'\nUSER='memcached'\nMAXCONN='96'\nCACHESIZE='32'\nOPTIONS=''"
     require => Package['memcached'],
  }
}
