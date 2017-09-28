class profile::wordpress {
	class { '::mysql::server':
		root_password => 'puppet4thewin',
	}
	
	class { 'mysql::bindings':
		php_enable => true
	}
	
	include ::apache
	include ::apache::mod::php
	
	apache::vhost { $facts['fqdn']:
		port => '80',
		docroot => '/opt/wordpress',
		priority => '80',
	}
	
	include ::wordpress
}
