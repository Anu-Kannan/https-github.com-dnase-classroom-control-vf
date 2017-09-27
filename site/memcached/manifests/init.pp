class memcached {
package { 'memcached':
ensure => present,
}
file{ '/etc/sysconfig/memcached':


}
}
