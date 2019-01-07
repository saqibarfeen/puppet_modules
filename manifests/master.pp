class trace9::master{
package { 'git': }
#mysql::db { 'icinga2':
#  user     => 'icinga2',
#  password => 'supersecret',
#  host     => 'hassan',
#  grant    => ['SELECT', 'INSERT', 'UPDATE', 'DELETE', 'DROP', 'CREATE VIEW', 'CREATE', 'INDEX', 'EXECUTE', 'ALTER'],
#}
class { '::icinga2':
  features  => ['checker','mainlog','notification','statusdata','compatlog','command'],
  constants => {
    'ZoneName' => 'master',
    'TicketSalt'   => '5a3d695b8aef8f18452fc494593056a4',
  }
}
class { '::icinga2::feature::api':
  pki             => 'none',
  endpoints       => {
    'master'    => { 'host' => '172.31.1.171'},
    'hassan' => { 'host' => '172.31.1.172'
    }
  },
  zones           => {
    'master' => {
      'endpoints' => ['master'],
     },
    'client'    => {
      'endpoints' => ['hassan'],
      'parent'    => 'master',
     },
     'director-global' => {
	'global' => true,
	}
 }
}

class{ '::icinga2::feature::idomysql':
  host          => 'hassan', 
  user          => 'icinga2',
  password      => 'supersecret',
  database      => 'icinga2',
  import_schema => true,
#  require       => Mysql::Db['icinga2'],
}
}
