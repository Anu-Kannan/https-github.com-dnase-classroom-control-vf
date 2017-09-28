class nginx:params {

	$service = 'nginx'
	$port = '80'

	case $facts['osfamily'] {
		'Redhat', 'Debian': {
			$package = 'nginx'
			$owner = 'root'
			$group = 'root'
			$docRoot = '/var/www'
			$configDir = '/etc/nginx'
			$serverBlock = '/etc/nginx/conf.d'
			$logDir = '/var/log/nginx'
		}
		'windows': {
			$winPath = 'C:/ProgramData/nginx'
			$package = 'nginx-server'
			$owner = 'Administrator'
			$group = 'Administrator'
			$docRoot = "${winPath}/html"
			$configDir = "${winPath}"
			$serverBlock = "${winPath}/conf.d"
			$logDir = "${winPath}/logs"
		}
	}
	$nginxUser = $facts['osfamily'] ? {
		'Debian' => 'www-data',
		'windows' => 'nobody',
		default => 'nginx',
	}
}
