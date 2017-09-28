define users::managed_user (
  $username = $title,
  $homedir = "/home/${username}",
) {
  user { $username:
  ensure => present,
  }
  file { $homedir:
    ensure => directory,
    owner => $username,
    group => $username,
    mode => '0700',
  }
  group { $groupname:
    ensure => present,
  }
  file { "${homedir}/.ssh":
    ensure => directory,
  }
}
