class profile::wordpress {
  class { 'mysql::server':
    root_password => 'puppet4tehwin',
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
  #note
  include ::wordpress
}
