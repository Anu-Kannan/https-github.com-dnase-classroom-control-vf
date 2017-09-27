class nginx {
$service = 'nginx'  
$port = '80'  
case $::osfamily {    
'RedHat', 'Debian': {      
$package = 'nginx'      
$owner = 'root'      
$group = 'root'      
$docroot = '/var/www'       
$confdir = '/etc/nginx'       
$blockdir = '/etc/nginx/conf.d'       
$logdir = '/var/log/nginx'     
}     
'windows': {       
$package = 'nginx-service'      
$owner = 'Administrator'       
$group = 'Administrators'       
$docroot = 'C:/ProgramData/nginx/html'      
$confdir = 'C:/ProgramData/nginx'      
$blockdir = 'C:/ProgramData/nginx/conf.d'      
$logdir = 'C:/ProgramData/nginx/logs'    
}
}   
$user = $::osfamily ? {     
'Debian' => 'www-data',     
'windows' => 'nobody',     
default => 'nginx',   
}
File {
owner => 'root',    
group => 'root',    
mode => '0644',
}
  package {'nginx':
  ensure => present,
}
file {'/var/www':
  ensure => directory,
  }
file {'/var/www/index.html':
  ensure => file,
  source => 'puppet:///modules/nginx/index.html',
}
file {'/etc/nginx/nginx.conf':
  ensure => file,
  content => epp('nginx/nginx.conf.epp', {       
  nginx_user => $user,       
  logdir => $logdir,       
  confdir => $confdir,       
  blockdir => $blockdir,  
  }),
  require => Package['nginx'],
  notify => Service['nginx'],
}
file { '/etc/nginx/conf.d':
  ensure => directory,
  }
file { '/etc/nginx/conf.d/default.conf':
  ensure => file,
  content => epp('nginx/default.conf.epp', {       
  port => $port,       
  docroot => $docroot,     
  }),
  require => Package['nginx'],
  notify => Service['nginx'],
}
service { 'nginx':
  ensure => running,
  enable => true,
  subscribe => File['/etc/nginx/nginx.conf', '/etc/nginx/conf.d/default.conf'],
 }
}
