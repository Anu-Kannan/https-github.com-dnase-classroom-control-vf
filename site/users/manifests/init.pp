# ${modulepath}/users/manifests/init.pp
class users {
  user { 'fundamentals':
    ensure => present,
  }
}
