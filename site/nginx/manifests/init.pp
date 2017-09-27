class nginx {
  $source = 'puppet:///modules/nginx/'
  case $facts['os']['name'] {
    'redhat', 'centos': { 
      $packname = 'nginx'
      $owner    = 'root'
      $group    = 'root'
      $docroot  = '/var/www'
      $confdir  = '/etc/nginx'
      $servdir  = '/etc/nginx/conf.d'
      $logsdir  = '/var/log/nginx'
      $service  = 'nginx'
      $runas    = 'nginx'
    } # apply the RedHat class
    'debian', 'ubuntu': { 
      $packname = 'nginx'
      $owner    = 'root'
      $group    = 'root'
      $docroot  = '/var/www'
      $confdir  = '/etc/nginx'
      $servdir  = '/etc/nginx/conf.d'
      $logsdir  = '/var/log/nginx'
      $service  = 'nginx'
      $runas    = 'www-data'      
    } # apply the Debian class
    'windows'         : {
      $packname = 'nginx-service'
      $owner    = 'Administrator'
      $group    = 'Administrators'
      $docroot  = 'C:/ProgramData/nginx/html'
      $confdir  = 'C:/ProgramData/nginx'
      $servdir  = 'C:/ProgramData/nginx/conf.d'
      $logsdir  = 'C:/ProgramData/nginx/logs'
      $service  = 'nginx'
      $runas    = 'nobody'
    } # apply the Windows class
    default:  { fail("Unsupported OS: ${facts['os']['name']}") }
  }
    
  File {
    owner   => "${owner}",
    group   => "${group}",
    mode    => '0644',
  }
  
  package {"${packname}":
    ensure  => present,
  }

  file {"${docroot}":
    ensure  => directory,
  }
  
  file {"${docroot}/index.html":
    ensure  => file,
    source  => "${source}index.html",
  }
  
  file {"${confdir}/nginx.conf":
    ensure  => file,
    source  => "${source}nginx.conf",
    require => Package[$packname],
  }
  
  file {"${servdir}/default.conf":
    ensure  => file,
    content => epp('nginx/default.conf.epp', { docroot => $docroot })
    require => Package[$packname],
  }
  
  service {'nginx':
    ensure  => running,
    enable    => true,
    subscribe => File["${confdir}/nginx.conf","${servdir}/default.conf"]
  }
}
