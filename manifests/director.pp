node 'node02'{

#director
package { 'git': }
include ::mysql::server

mysql::db { 'director':
  user     => 'director',
  password => 'director',
  host     => 'localhost',
  charset  => 'utf8',
  grant    => ['SELECT', 'INSERT', 'UPDATE', 'DELETE', 'DROP', 'CREATE VIEW', 'CREATE', 'INDEX', 'EXECUTE', 'ALTER', 'REFERENCES'],
}

class {'icingaweb2':
  manage_repo   => true,
  import_schema => true,
  db_type       => 'mysql',
  db_host       => 'localhost',
  db_port       => 3306,
  db_username   => 'icingaweb2',
  db_password   => 'icingaweb2',
}

class {'icingaweb2::module::monitoring':
  ido_host          => 'hassan',
  ido_db_name       => 'icinga2',
  ido_db_username   => 'icinga2',
  ido_db_password   => 'supersecret',
  commandtransports => {
    icinga2 => {
      transport => 'api',
      host => 'master',
      username  => 'icinga',
      password  => 'icinga',
    }
  }
}

class {'icingaweb2::module::director':
  git_revision  => 'v1.6.0',
  db_host       => 'localhost',
  db_name       => 'director',
  db_username   => 'director',
  db_password   => 'director',
  import_schema => true,
  kickstart     => true,
  endpoint      => 'master',
  api_username  => 'icinga',
  api_password  => 'icinga',
  require       => Mysql::Db['director']
}

#web
class { 'apache':
  mpm_module => 'prefork'
}

class { 'apache::mod::php': }

case $::osfamily {
  'redhat': {
    package { 'php-mysql': }

    file {'/etc/httpd/conf.d/icingaweb2.conf':
      source  => 'puppet:///modules/icingaweb2/examples/apache2/icingaweb2.conf',
      require => Class['apache'],
      notify  => Service['httpd'],
    }

    package { 'centos-release-scl':
      before => Class['icingaweb2']
    }
  }
  'debian': {
    class { 'apache::mod::rewrite': }

    file {'/etc/apache2/conf.d/icingaweb2.conf':
      source  => 'puppet:///modules/icingaweb2/examples/apache2/icingaweb2.conf',
      require => Class['apache'],
      notify  => Service['apache2'],
    }
  }
  default: {
    fail("Your plattform ${::osfamily} is not supported by this example.")
  }
}

include ::mysql::server

mysql::db { 'icingaweb2':
  user     => 'icingaweb2',
  password => 'icingaweb2',
  host     => 'localhost',
  grant    => ['SELECT', 'INSERT', 'UPDATE', 'DELETE', 'DROP', 'CREATE VIEW', 'CREATE', 'INDEX', 'EXECUTE', 'ALTER', 'REFERENCES'],
}


#auth method
icingaweb2::config::authmethod {'external-auth':
  backend => 'external',
  order   => '01',
}

icingaweb2::config::resource{'my-sql':
  type        => 'db',
  db_type     => 'mysql',
  host        => 'localhost',
  port        => 3306,
  db_name     => 'icingaweb2',
  db_username => 'icingaweb2',
  db_password => 'supersecret',
}

icingaweb2::config::authmethod {'db-auth':
  backend  => 'db',
  resource => 'my-sql',
  order    => '02',
}

}
#webnode end
