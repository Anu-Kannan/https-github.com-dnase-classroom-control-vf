class wrapper::epel {
  class {'::epel':
    epel_testing_enables => '1',
    epel_source_enabled => '1',
  }
}
