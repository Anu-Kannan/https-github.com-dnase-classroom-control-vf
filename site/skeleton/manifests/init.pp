class skeleton {
  file { '/etc/skel':
    ensure => 'directory',
  }
  file { '/etc/skel/.bashrc':
    ensure => 'file',
    require => File['/etc/skel'],
    source => 'puppet:///modules/skeleton/bashrc',
}
