# ${modulepath}/nginx/manifests/init.pp

class nginx {
  package { 'nginx':
    ensure => present, }
    #file { '/etc/nginx/nginx.conf':
  }
  
  file { '/var/www':
    ensure => directory,
  }
  
  file { "index.html":
    ensure => file,
		path => '/var/www/index.html',
    source => 'puppet:///modules/nginx/index.html',
    require => Package['nginx'],
  }

  file { 'puppet.png':
    ensure => file,
    require => Package['nginx'],
		path => '/var/www/puppet.png',
    source => 'puppet:///modules/nginx/puppet.png',
  }

  file { 'nginx.conf':
    ensure => file,
		path => '/etc/nginx/nginx.conf',
    source => 'puppet:///modules/nginx/nginx.conf',
    require => Package['nginx'],
  }

	file { 'default.conf':
    ensure => file,
		path => '/etc/nginx/conf.d/default.conf',
    source => 'puppet:///modules/nginx/nginx.conf',
    require => Package['nginx'],
  }
	
	file { '/etc/nginx/conf.d/default.conf'

  service { 'nginx':
    ensure => running,
    enable => true,
    subscribe => File['nginx.conf', 'default.conf', 'puppet.png'],
  }
  
}
