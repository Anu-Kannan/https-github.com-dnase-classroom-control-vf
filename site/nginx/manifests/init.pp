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
  
