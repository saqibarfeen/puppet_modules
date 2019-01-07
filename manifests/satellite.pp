
class trace9::satellite{

$master_cert = 'master'
$master_ip   = 'master'

class { '::icinga2':
  manage_repo  => true,
  constants    => {
    'NodeName' => 'hassan',
  },
}

class { '::icinga2::feature::api':
  pki             => 'icinga2',
  ca_host         => $master_ip,
  ticket_salt     => '5a3d695b8aef8f18452fc494593056a4',
  accept_config   => true,
  accept_commands => true,
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
  }
}
}
