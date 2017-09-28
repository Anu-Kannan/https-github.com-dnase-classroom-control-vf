class wrappers::redis {
  class { '::redis;"
    require => class
}
