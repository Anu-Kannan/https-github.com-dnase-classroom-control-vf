class memcached {
package { 'memcached':
ensure => present,
}
file { 'memcached':
    ensure => file,
    content => content => "PORT='11211'\nUSER='memcached'\nMAXCONN='96'\nCACHESIZE='32'\nOPTIONS=''",
    path => '/etc/sysconfig/memcached',
    source => 'puppet:///modules/nginx/nginx.conf',
    require => Package['memcached'],
}
service { 'memcached':
    ensure => running,
    enable => true,
    subscribe => File['memcached'],
}
}
