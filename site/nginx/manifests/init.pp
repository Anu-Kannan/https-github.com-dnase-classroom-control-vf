class nginx (
  String $package = $nginx::params::package,
  String $owner = $nginx::params::owner,
  String $group = $nginx::params::group,
  String $docroot = $nginx::params::docroot,
  String $confdir = $nginx::params::confdir,
  String $logdir = $nginx::params::logdir,
) inherits nginx::params {
  File {
    owner => $owner,
    group => $group,
    mode => '0644',
  }
  package { $package:
    ensure => present,
  }
  file { [ $docroot, "${confdir}/conf.d" ]:
    ensure => directory,
  }
  file { "${docroot}/index.html":
    ensure => file,
    source => 'puppet:///modules/nginx/index.html',
  }
  file { 'nginx.conf':
    ensure => file,
    path => "${confdir}/nginx.conf",
    content => epp('nginx/nginx.conf.epp', {
      user => $user,
      confdir => $confdir,
      logdir => $logdir,
    }),
    notify => Service['nginx'],
  }
  file { 'default.conf':
    ensure => file,
    path => "${confdir}/conf.d/default.conf",
    content => epp('nginx/default.conf.epp', {
      docroot => $docroot,
    }),
    notify => Service['nginx'],
  }
  service { 'nginx':
    ensure => running,
    enable => true,
    subscribe => File['nginx.conf', 'default.conf'],
  }
}
