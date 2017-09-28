class users::admins {
  users::managed_user { 'jose': }
  users::managed_user { 'alice':
    groupname => 'leverage',
  }
  users::managed_user { 'chen': }
}
