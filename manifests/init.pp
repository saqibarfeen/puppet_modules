# Class: trace9
# ===========================
#
# Full description of class trace9 here.
#
# Parameters
# ----------
#
# Document parameters here.
#
# * `sample parameter`
# Explanation of what this parameter affects and what it defaults to.
# e.g. "Specify one or more upstream ntp servers as an array."
#
# Variables
# ----------
#
# Here you should define a list of variables that this module would require.
#
# * `sample variable`
#  Explanation of how this variable affects the function of this class and if
#  it has a default. e.g. "The parameter enc_ntp_servers must be set by the
#  External Node Classifier as a comma separated list of hostnames." (Note,
#  global variables should be avoided in favor of class parameters as
#  of Puppet 2.6.)
#
# Examples
# --------
#
# @example
#    class { 'trace9':
#      servers => [ 'pool.ntp.org', 'ntp.local.company.com' ],
#    }
#
# Authors
# -------
#
# Author Name <author@domain.com>
#
# Copyright
# ---------
#
# Copyright 2019 Your name here, unless otherwise noted.
#
class trace9(
  Optional[Variant[String, Array[String]]] $protected_customvars = ['*pw*', '*pass*', 'community'],
  Optional[String]               $ido_host             = undef,
  Integer[1,65535]               $ido_port             = 3306,
  Optional[String]               $ido_db_name          = undef,
  Optional[String]               $ido_db_username      = undef,
  Optional[String]               $ido_db_password      = undef,
  Optional[String]               $ido_db_charset       = undef,
  Optional[Hash]                           $commandtransports    = undef,
) {
if("director" in $role){
	include trace9::director
}
if("master" in $role){
	include trace9::master
	include trace9::inhouse_plugins
}
if("satellite" in $role){
	include trace9::satellite
	include trace9::inhouse_plugins
}
}
