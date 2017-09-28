class users::admins {
  users::managed_user { 'jose': }
  users::managed_user { 'alice':
    groupname => 'chickenheads',
  }
  users::managed_user { 'chen': }
}
