class users::admins {
  users::managed_user { 'jim': }
  users::managed_user { 'allen':
  group => 'staff',
}
users::managed_user { 'parker':
  group => 'staff',
}
group { 'staff':
ensure => present,
}
}
