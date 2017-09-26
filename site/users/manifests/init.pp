class users {
  user { 'fundamentals':
  ensure => present,
  home => '/home/fundamentals',
  gid => 'wheel',
  managehome => true,
  }
}
