class nginx {
  $source = 'puppet:///modules/nginx/'
  $service  = 'nginx'
  $port = '80'
  
  case $::osfamily {
    'RedHat', 'Debian': { 
      $packname = 'nginx'
      $owner    = 'root'
      $group    = 'root'
      $docroot  = '/var/www'
      $confdir  = '/etc/nginx'
      $servdir  = '/etc/nginx/conf.d'
      $logsdir  = '/var/log/nginx'
    } 
    'windows'         : {
      $packname = 'nginx-service'
      $owner    = 'Administrator'
      $group    = 'Administrators'
      $docroot  = 'C:/ProgramData/nginx/html'
      $confdir  = 'C:/ProgramData/nginx'
      $servdir  = 'C:/ProgramData/nginx/conf.d'
      $logsdir  = 'C:/ProgramData/nginx/logs'
      $runas    = 'nobody'
    } # apply the Windows class
    default:  { fail("Unsupported OS: ${facts['os']['name']}") }
  }
  
  
  $runas    = $::osfamily ? {
    'Debian' => 'www-data',
    'windows' => 'nobody',
    default => 'nginx',
  }
    
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
  
  file {"${docroot}/index.html":
    ensure  => file,
    source  => "${source}index.html",
  }
  
  file {"${confdir}/nginx.conf":
    ensure  => file,
    content => epp('nginx/nginx.conf.epp', { 
        runas => $runas,
        logsdir => $logsdir,
        confdif => $confdir,
        servdir => $servdir,
      }
    )
    require => Package[$packname],
  }
  
  file {"${servdir}/default.conf":
    ensure  => file,
    content => epp('nginx/default.conf.epp', { 
        port => $port,
        docroot => $docroot,
      }
    )
    require => Package[$packname],
  }
  
  service {'nginx':
    ensure  => running,
    enable    => true,
    subscribe => File["${confdir}/nginx.conf","${servdir}/default.conf"]
  }
}
