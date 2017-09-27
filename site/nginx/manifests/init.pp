class nginx {
  case $::osfamily {
     'RedHat', 'Debian': {
     $package = 'nginx'
     $owner = 'root'
     $group = 'root'
     $docroot = '/var/www'
     $confdir = '/etc/nginx'
     $blockdir = '/etc/nginx/conf.d'
     $logdir = '/var/log/nginx'
     $service = 'nginx'
    }
    'windows': {
     $package = 'nginx-service'
     $owner = 'Administrator'
     $group = 'Administrators'
     $docroot = 'C:/ProgramData/nginx/html'
     $confdir = 'C:/ProgramData/nginx'
File {
    owner => 'root',
    group => 'root',
    mode => '0644',
}
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
file { 'nginx.conf':
ensure => file,
path => '/etc/nginx/nginx.conf',
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
