class nginx (
  Optional[String] $root = undef,
) inherits nginx::params {
  
  File {
    owner   => $owner,
    group   => $group,
    mode    => '0644',
  }
  
  package {$packname:
    ensure  => present,
  }

  file {$docroot:
    ensure  => directory,
  }
  
  file {'index.html':
    ensure  => file,
    path => "${docroot}/index.html",
    source  => "${source}index.html",
  }
  
  file {'nginx.conf':
    ensure  => file,
    path => "${confdir}/nginx.conf",
    content => epp('nginx/nginx.conf.epp', { 
        runas => $runas,
        logsdir => $logsdir,
        confdir => $confdir,
        servdir => $servdir,
      }
    ),
    require => Package[$packname],
  }
  
  file {'default.conf':
    ensure  => file,
    path => "${servdir}/default.conf",
    content => epp('nginx/default.conf.epp', { 
        port => $port,
        docroot => $docroot,
      }
    ),
    require => Package[$packname],
  }
  
  service {'nginx':
    ensure  => running,
    enable    => true,
    subscribe => File['nginx.conf','default.conf']
  }
}
