class nginx {
  package { 'nginx':
    ensure => present,
  }
  
  file { '/var/www':
    ensure => directory,
    owner => 'root',
    group => 'root',
    mode => '0775',
  }
  file { '/var/www/index.html':
    ensure => file,
    owner => 'root',
    group => 'root',
    mode => '0664',
    source => 'puppet:///modules/nginx/index.html',
  }
  
  file { 'nginx.conf':
    ensure => file,
    owner => 'root',
    group => 'root',
    mode => '0664',
    path => '/etc/nginx/nginx.conf',
    source => 'puppet:///modules/nginx/nginx.conf',
    require => Package['nginx'],
  }
  file { 'default.conf':
    ensure => file,
    owner => 'root',
    group => 'root',
    mode => '0664',
    path => '/etc/nginx/conf.d/default.conf',
    source => 'puppet:///modules/nginx/default.conf',
    require => Package['nginx'],
  }
  
  service { 'nginx':
    ensure => running,
    enable => true,
    subscribe => File['nginx.conf', 'default.conf'],
  }
}


