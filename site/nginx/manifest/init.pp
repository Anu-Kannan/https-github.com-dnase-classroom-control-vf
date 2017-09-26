class nginx { 
  package { 'nginx_pack':
    ensure => present,
  }
  file { 'nginx_conf':
    ensure => 'file',
    path => '/etc/nginx/nginx.conf',
    require => Package['nginx_pack'],
    source => 'puppet://modules/nginx/nginx.conf
  }
  file { 'nginx_default':
    ensure => 'file',
    path => '/etc/nginx/conf.d/default.conf',
    require => Package['nginx_pack'],
    source => 'puppet://modules/nginx/default.conf
  }
  file { 'nginx_index':
    ensure => 'file,
    path => '/var/www/index.html',
    source => 'puppet://modules/nginx/default.conf',
  }
  service { 'nginx_service':
    ensure => 'running',
    enable => 'true',    
    subscribe => File ['/etc/nginx/nginx.conf'],
    name => 'nginx',
  }
}
