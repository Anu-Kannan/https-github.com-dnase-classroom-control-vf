class  users::admins {
	users::managed_user { 'jose': }
	users::managed_user { 'jane': 
		groupName => 'chickenheads',
 	}
	users::managed_user { 'mary': }
}
