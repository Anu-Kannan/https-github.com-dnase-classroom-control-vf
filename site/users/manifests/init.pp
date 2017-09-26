class users{
users { 'fundamentals':
ensure => present,
managehome => true,
gid => 'wheel',
}
}
