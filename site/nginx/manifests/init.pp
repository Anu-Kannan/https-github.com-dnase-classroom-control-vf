class nginx {

	$service = 'nginx'
	$port = '80'
	

	case $facts['osfamily'] {
		'Redhat', 'Debian': {
			$package = 'nginx'
			$owner = 'root'
			$group = 'root'
			$docRoot = '/var/www'
			$configDir = '/etc/nginx'
			$blockDir = '/etc/nginx/conf.d'
			$logDir = '/var/log/nginx'
		}
		'windows': {
			$winPath = 'C:/ProgramData/nginx'
			$package = 'nginx-server'
			$owner = 'Administrator'
			$group = 'Administrator'
			$docRoot = "${winPath}/html"
			$configDir = "${winPath}"
			$blockDir = "${winPath}/conf.d"
			$logDir = "${winPath}/logs"
		}
	}
	$nginxUser = $facts['osfamily'] ? {
		'Debian' => 'www-data',
		'windows' => 'nobody',
		default => 'nginx',
	}

	File {
		owner => 'root',
		group => 'root',
		mode => '0644',
	}

	package { 'nginx':
		ensure => present,
	}
	
	file { '/var/www':
		ensure => directory,
	}
	
	file { '/var/www/index.html':
		ensure => file,
		source => 'puppet:///modules/nginx/index.html',
	}
	
	file { 'nginx.conf':
		ensure => file,
		path => '/etc/nginx/nginx.conf',
		content => epp('nginx/nginx.conf.epp', {
			nginxUser => $nginxUser,
			logDir => $logDir,
			configDir => $confDir,
			blockDir => $blockDir,
		}),
		require => Package['nginx'],
	}
	
	file { 'default.conf':
		ensure => file,
		path => '/etc/nginx/conf.d/default.conf',
		content => epp('nginx/default.conf.epp', {
			port => $port,
			docRoot => $docRoot,			
		}),
		require => Package['nginx'],
	}
	
	file { 'puppet.png':
		ensure => file,
		require => Package['nginx'],
		path => '/var/www/puppet.png',
		source => 'puppet:///modules/nginx/puppet.png',
	}
	
	service { 'nginx':
		ensure => running,
		enable => true,
		subscribe => File['nginx.conf', 'default.conf'],
	}
}
