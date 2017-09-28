class  users::admins {
	users::managed_user { 'jose': }
	users::managed_user { 'jane': 
		groupname => 'chickenheads',
 	}
	users::managed_user { 'mary': }
}
