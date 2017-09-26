# ${modulepath}/nginx/manifests/init.pp

class nginx {
  package { 'openssh':
    ensure => present, }
    file { '/etc/nginx/nginx.conf':
  }
  
  file { "/var/www/index.html":
    ensure => file,
    owner => 'root',
    group => 'root',
    mode => '0644',
    require => Package['nginx'],
    source => 'puppet:///modules/nginx/index.html',
  }

  service { 'nginx':
    ensure => running,
    enable => true,
    subscribe => File['/etc/nginx/nginx.conf'],
  }
}
