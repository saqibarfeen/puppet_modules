
#include ::mysql::server

node 'hassan99'{

$override_options = {
'bind-address' => '0.0.0.0'
}

class { '::mysql::server':
  root_password           => 'cloud9net',
  remove_default_accounts => true,
  override_options        => $override_options
}

mysql::db { 'icinga2':
  user     => 'icinga2',
  password => 'supersecret',
  host     => '%',
  grant    => ['SELECT', 'INSERT', 'UPDATE', 'DELETE', 'DROP', 'CREATE VIEW', 'CREATE', 'INDEX', 'EXECUTE', 'ALTER'],
}

}
