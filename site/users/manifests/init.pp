class users{
users { 'fundamentals':
ensure => present,
home => '/home/fundamentals',
managehome => true,
gid => 'wheel',
}
}
