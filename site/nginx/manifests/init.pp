class nginx (
  String $service = $nginx::params::service,
  String $port = $nginx::params::port,
  String $package = $nginx::params::package,
  String $owner = $nginx::params::owner,
  String $group = $nginx::params::group,
  String $docroot = $nginx::params::docroot,
  String $confdir = $nginx::params::confdir,
  String $blockdir = $nginx::params::blockdir,
  String $logdir = $nginx::params::logdir,
  String $user = $nginx::params::user,
) inherits nginx::params {
  File {
    owner => 'root',
    group => 'root',
    mode => '0644',
  }
  package { 'nginx':
    ensure => present,
  }  
  file { $docroot:
    ensure => directory,
  }
  file { "${docroot}/index.html":
    ensure => file,
    source => 'puppet:///modules/nginx/index.html',
  }
  file { 'nginx.conf':
    ensure => file,
    path => '/etc/nginx/nginx.conf',
    content => epp('nginx/nginx.conf.epp', {
      nginx_user => $user,
      logdir => $logdir,
      confdir => $confdir,
      blockdir => $blockdir,
    }),
    require => Package['nginx'],
  }
  file { 'default.conf':
    ensure => file,
    path => '/etc/nginx/conf.d/default.conf',
    content => epp('nginx/default.conf.epp', {
      port => $port,
      docroot => $docroot,
    }),
    require => Package['nginx'],
  }  
  service { 'nginx':
    ensure => running,
    enable => true,
    subscribe => File['nginx.conf', 'default.conf'],
  }
}
