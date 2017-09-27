class nginx{
package{ 'nginx':
   ensure=>present,
}
file{'/var/www':
   ensure => directory,
   owner => 'root',
   group => 'root',
   mode => '0775',
}
file{'nginx.conf':
   ensure=>file,
   owner=>'root',
   group=>'root',
   mode=>'0664',
   path=>'/etc/nginx/nginx.conf'
   source=>'puppet:///modules/nginx/nginx.conf',
   require => Package['nginx'],
   notify => Service['nginx'],
}
file{ 'default.conf':
   ensure=>file,
   owner=>'root',
   group=>'root',
   mode=>'0775',
   path=>'/etc/nginx/conf.d/default.conf'
   source=>'puppet:///modules/nginx/conf.d/default.conf',
   require => Package['nginx'],
   notify => Service['nginx'],
}
service { 'nginx':
   ensure => running,
   enable => true,
}   
file{'/var/www/index.html':
   ensure=>file,
   owner=>'root',
   group=>'root',
   mode=>'0775',
   source=>'puppet:///modules/nginx/index.html',
}
}
