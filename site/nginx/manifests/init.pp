class nginx {
  File{
      owner => 'root',
      group => 'root',
  }
  package { 'nginx':
    ensure => present,
  }
  
  file { '/var/www':
    ensure => directory,
    mode => '0775',
  }
  file { '/var/www/index.html':
    ensure => file,
    mode => '0664',
    source => 'puppet:///modules/nginx/index.html',
  }
  
  file { 'nginx.conf':
    ensure => file,
    mode => '0664',
    path => '/etc/nginx/nginx.conf',
    source => 'puppet:///modules/nginx/nginx.conf',
    require => Package['nginx'],
  }
  file { 'default.conf':
    ensure => file,
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


