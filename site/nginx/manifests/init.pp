class nginx (
  Optional[String] $root = undef,
  String $source = $nginx::params::source,
  String $service = $nginx::params::service,
  String $port = $nginx::params::port,
  String $packname = $nginx::params::packname,
  String $owner    = $nginx::params::owner,
  String $group    = $nginx::params::group,
  String $docroot  = $nginx::params::docroot,
  String $confdir  = $nginx::params::confdir,
  String $servdir  = $nginx::params::servdir,
  String $logsdir = $nginx::params::logsdir,
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
