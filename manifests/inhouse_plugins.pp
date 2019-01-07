
class trace9::inhouse_plugins{

file {
 '/usr/lib64/nagios/plugins/':
  ensure => 'directory',
  source => 'puppet:///modules/trace9/plugins',
  recurse => 'remote',
  path => '/usr/lib64/nagios/plugins/',
  owner => 'icinga',
  group => 'icinga',
  mode  => '0755', # Use 0700 if it is sensitive
}

}
