class nginx::params {
  $service = 'nginx'
  $port = '80'
  case $::osfamily {
    'RedHat', 'Debian': {
      $package = 'nginx'
      $owner = 'root'
      $group = 'root'
      $docroot = '/var/www'
      $confdir = '/etc/nginx'
      $blockdir = '/etc/nginx/conf.d'
      $logdir = '/var/log/nginx'
    }
    'windows': {
      $package = 'nginx-service'
      $owner = 'Administrator'
      $group = 'Administrators'
      $docroot = 'C:/ProgramData/nginx/html'
      $confdir = 'C:/ProgramData/nginx'
      $blockdir = 'C:/ProgramData/nginx/conf.d'
      $logdir = 'C:/ProgramData/nginx/logs'
    }
  }
  $user = $::osfamily ? {
    'Debian' => 'www-data',
    'windows' => 'nobody',
    default => 'nginx',
  }
  $docroot = pick($root, $default_docroot)
}
