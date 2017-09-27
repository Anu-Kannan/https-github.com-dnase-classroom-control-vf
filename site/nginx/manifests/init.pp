class nginx {
  File {
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    require => Package['nginx'],
  }
  
  package {'nginx':
    ensure  => present,
  }

  file {'/var/www':
    ensure  => directory,
  }
  
  file {'/var/www/index.html':
    ensure  => file,
    source  => 'puppet:///modules/nginx/index.html',
  }
  
  file {'/etc/nginx/nginx.conf':
    ensure  => file,
    source  => 'puppet:///modules/nginx/nginx.conf',
  }
  
  file {'/etc/nginx/conf.d/default.conf':
    ensure  => file,
    source  => 'puppet:///modules/nginx/default.conf',
  }
  
  service {'nginx':
    ensure  => running,
    enable    => true,
    subscribe => File['/etc/nginx/nginx.conf','/etc/nginx/conf.d/default.conf']
  }
}
