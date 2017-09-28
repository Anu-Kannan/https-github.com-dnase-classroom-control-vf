define users::managed_user (
  $username = $title,
  $groupname = $username,
  $homedir = "/home/${title}",
) {
  
  File {
    owner => $username,
    group => $username,
    mode => '0700',
  }
  
  group { $groupname:
    ensure => present,
  }
  
  file { $homedir:
    ensure => directory,
    managehome => true,
  }
  
  file { "${username}/.shh":
    ensure => directory,
    managehome => true,
  }
  
}
