define users::managed_user (
  $username = $title,
  $homedir = "/home/${username}",
  $groupname = $username,
) {
  File {
    owner => $username,
    group => $groupname,
    mode => '0700',
  }
  
  group { $groupname:
    ensure => present,
  }
  
  user { $username:
    ensure => present,
    gid => $groupname,
    home => $homedir,
    managehome => $true,
  }
  
  file {
    ensure => directory,
  }
  file { "${homedir}/.ssh":
    ensure => directory,
  }
}
