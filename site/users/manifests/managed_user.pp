define users::managed_user (
  $username = $title,
  $groupname = $username,
  $homedir = "/home/${username}",
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
    managehome => true,
  }
  file { $homedir:
    ensure => directory,
  }
  file { "${homedir}/.ssh":
    ensure => directory,
  }
}
