# ${modulepath}/nginx/manifests/init.pp

class nginx {
  package { 'openssh':
    ensure => present, }
    file { '/etc/ssh/sshd_config':
  }
  
  file { "/var/www/index.html":
    ensure => file,
    owner => 'root',
    group => 'root',
    mode => '0644',
    require => Package['openssh'],
    source => 'puppet:///modules/nginx/index.html',
  }

  service { 'nginx':
    ensure => running,
    enable => true,
    subscribe => File['/var/www/index.html'],
  }
}
