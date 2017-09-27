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
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
  }
  
  package {'nginx':
    ensure  => present,
  }

  file {'/var/www':
    ensure  => directory,
  }
  
  file {'/var/www/index.html':
    ensure  => file,
    source  => "${source}index.html",
  }
  
  file {'/etc/nginx/nginx.conf':
    ensure  => file,
    source  => "${source}nginx.conf",
    require => Package['nginx'],
  }
  
  file {'/etc/nginx/conf.d/default.conf':
    ensure  => file,
    content => epp('nginx/default.conf.epp', { docroot => $docroot })
    require => Package['nginx'],
  }
  
  service {'nginx':
    ensure  => running,
    enable    => true,
    subscribe => File['/etc/nginx/nginx.conf','/etc/nginx/conf.d/default.conf']
  }
}
