# ${modulepath}/nginx/manifests/init.pp

class nginx {
  package { 'nginx':
    ensure => present, }
    file { '/etc/nginx/nginx.conf':
  }
  
  file { "/var/www":
    ensure => directory,
    owner => 'root',
    group => 'root',
  }
  
  file { "/var/www/index.html":
    ensure => file,
    owner => 'root',
    group => 'root',
    mode => '0644',
    require => Package['nginx'],
    source => 'puppet:///modules/nginx/index.html',
  }
  
  file { "/var/www/nginx.conf":
    ensure => file,
    owner => 'root',
    group => 'root',
    mode => '0644',
    require => Package['nginx'],
    source => 'puppet:///modules/nginx/nginx.conf',
  }

  service { 'nginx':
    ensure => running,
    enable => true,
    subscribe => File['/etc/nginx/nginx.conf'],
  }
  
}
