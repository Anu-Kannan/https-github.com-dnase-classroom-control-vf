class newuser { 
  user { 'fundamentals':  
    ensure => present,
    home => '/home/fundamentals',    
    managehome => true,    
    gid => 'wheel',
    }
}
