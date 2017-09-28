define users::managed_user (
  $grp = $title,
) {
  user { $title:
    ensure => present,
   }
   file { "/home/${title}":
    ensure => directory,
    owner => $title,
    group => $grp,
    }
 }
    
