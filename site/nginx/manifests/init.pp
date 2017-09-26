class nginx {
  package {'nginx':
    ensure  => present,
  }

  file {'/var/www':
    ensure  => directory,
  }
  
  file {'/etc/nginx/nginx.conf':
    ensure  => file,
    owner   => 'root',
    group   => 'root',
    mode    => '0440',
    source  => 'puppet:///modules/nginx/nginx.conf',
  }
  
  file {'/etc/nginx/conf.d/default.conf':
    ensure  => file,
    owner   => 'root',
    group   => 'root',
    mode    => '0440',
    source  => 'puppet:///modules/nginx/default.conf',
  }
  
  service {'nginx':
    ensure  => running,
  }
}
