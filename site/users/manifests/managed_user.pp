define users::managed_user (
	$userName = $title,
	$groupName = $userName,
	$homeDir = "/home/${userName}",
) {
	File {
		owner => $userName,
		group => $groupName,
		mode => '0700',
	}
	
	user { $userName:
		ensure => present,
		gid => $groupName,
		home => $homeDir,
		managedhome => true,
	}
	
	group { $username:
		ensure => present,
	}	
	
	file { $homeDir:
		ensure => directory,
	}
	
	file { "${homeDir}/.ssh":
		ensure => directory,
	}
}
