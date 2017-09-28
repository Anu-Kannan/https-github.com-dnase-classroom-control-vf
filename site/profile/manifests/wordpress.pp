class profile::wordpress {
  class {'mysql::server':
    root_password => 'puppet4tehwin'
    }
  class { 'mysql::bindings":
    php_enable => true,
  }
