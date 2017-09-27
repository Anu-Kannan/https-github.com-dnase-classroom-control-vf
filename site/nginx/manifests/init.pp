class nginx{
package{ 'nginx':
   ensure=>installed
}
file{'root':
   path=>'/var/www',
}
file{'nginx.conf':
   path=>'/etc/nginx/nginx.conf',
}
file{'default.conf':
   path=>'/etc/nginx/conf.d/default.conf',
}
}
