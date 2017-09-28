class nginx::params (
  Optional[String] $root = undef,
  ) {
  $source = 'puppet:///modules/nginx/'
  $service  = 'nginx'
  $port = '80'
  
  case $::osfamily {
    'RedHat', 'Debian': { 
      $packname = 'nginx'
      $owner    = 'root'
      $group    = 'root'
      $default_docroot  = '/var/www'
      $confdir  = '/etc/nginx'
      $servdir  = '/etc/nginx/conf.d'
      $logsdir  = '/var/log/nginx'
    } 
    'windows'         : {
      $packname = 'nginx-service'
      $owner    = 'Administrator'
      $group    = 'Administrators'
      $default_docroot  = 'C:/ProgramData/nginx/html'
      $confdir  = 'C:/ProgramData/nginx'
      $servdir  = 'C:/ProgramData/nginx/conf.d'
      $logsdir  = 'C:/ProgramData/nginx/logs'
    } # apply the Windows class
  }
  
  $docroot = pick($root,$default_root)
  
  $runas    = $::osfamily ? {
    'Debian' => 'www-data',
    'windows' => 'nobody',
    default => 'nginx',
  }
}
