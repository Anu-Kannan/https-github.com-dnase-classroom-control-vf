	class nginx:params {

	$service = 'nginx'
	$port = '80'


	case $facts['osfamily'] {
		'Redhat', 'Debian': {
			$package = 'nginx'
			$owner = 'root'
			$group = 'root'
			$deafultDocRoot = '/var/www'
			$configDir = '/etc/nginx'
			$serverBlock = '/etc/nginx/conf.d'
			$logDir = '/var/log/nginx'
		}
		'windows': {
			$winPath = 'C:/ProgramData/nginx'
			$package = 'nginx-server'
			$owner = 'Administrator'
			$group = 'Administrator'
			$deafultDocRoot = "${winPath}/html"
			$configDir = "${winPath}"
			$serverBlock = "${winPath}/conf.d"
			$logDir = "${winPath}/logs"
		}
	}
}
