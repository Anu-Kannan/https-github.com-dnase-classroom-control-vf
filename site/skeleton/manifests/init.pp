class skeleton{
  file { '/etc/skel':
      ensure => 'directory',
  }
  file{/etc/skel/.bashrv':
       ensure=> file,
       source=> 'puppet:///modules/skeleton/bashrc',
   }
}
