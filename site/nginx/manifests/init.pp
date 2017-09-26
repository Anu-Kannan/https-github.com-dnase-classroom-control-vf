class nginx {
  package { 'nginx':
  ensure => present,
  }
  file { '/site/nginx/files/nginx.conf':
  source => 
  }
  file { '/site/nginx/files/default.conf':
  source => 
  }
  
  
} 
