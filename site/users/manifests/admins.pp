class users::admins {
  users::manageduser { 'jose': }
  users::manageduser { 'alice':
    groupname => 'chickenheads',
  }
  users::manageduser { 'chen': }
}
