class profile::wordpress {
  class { 'mysql::server':
    root_password => 'lancie',
    }
  class { 'mysql::bindings':
    php_enable => true,
  }
  
  include apache
  include apache::mod::php
  apache::vhost { $::fqdn:
    port => '80',
    docroot => '/opt/wordpress',
    priority => '00',
  }
  
  include ::wordpress
}
