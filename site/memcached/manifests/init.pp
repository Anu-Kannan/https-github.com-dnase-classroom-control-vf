class memcached {
  package { 'memcached':
    ensure => present, 
  }
  
  service { 'memcached':
    ensure => running,
  }
  
  file { '/etc/sysconfig/memcached':
     ensure => file,
     source => 'puppet:///modules/memcached/memcached',
  }
}
