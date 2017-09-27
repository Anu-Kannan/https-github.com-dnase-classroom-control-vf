class nginx {
package { 'nginx': 
ensure => present,
  }
file { '/var/www': 
ensure => directory,
 }
file { '/var/www/index.html':
ensure => file,
source => 'puppet:///modules/nginx/index.html',
}
file { '/etc/nginx/nginx.conf':
ensure => file,
source => 'puppet:///modules/nginx/nginx.conf',
require => Package['nginx'],
}
file { '/etc/nginx/conf.d':
ensure => directory,
 }
file { 'default.conf':
ensure => file,
path => '/etc/nginx/conf.d/default.conf',
source => 'puppet:///modules/nginx/default.conf',
require => Package['nginx'],
notify => Service['nginx'],
}
service { 'nginx':
ensure => running,
enable => true,
subscribe => File['nginx.conf', 'default.conf'],
}
}
