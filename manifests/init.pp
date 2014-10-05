# == Class: psad
#
# Full description of class psad here.
#
# === Parameters
#
# Document parameters here.
#
# [*sample_parameter*]
#   Explanation of what this parameter affects and what it defaults to.
#   e.g. "Specify one or more upstream ntp servers as an array."
#
# === Variables
#
# Here you should define a list of variables that this module would require.
#
# [*sample_variable*]
#   Explanation of how this variable affects the funtion of this class and if
#   it has a default. e.g. "The parameter enc_ntp_servers must be set by the
#   External Node Classifier as a comma separated list of hostnames." (Note,
#   global variables should be avoided in favor of class parameters as
#   of Puppet 2.6.)
#
# === Examples
#
#  class { 'psad':
#    servers => [ 'pool.ntp.org', 'ntp.local.company.com' ],
#  }
#
# === Authors
#
# Author Name <author@domain.com>
#
# === Copyright
#
# Copyright 2014 Your name here, unless otherwise noted.
#
class psad (
  $options = {},
  $autodl = {},
  $commands = {},
  $firewall_enable = true,
  $firewall_priority = 895,
  $cronjob_enable = true
) inherits psad::params {

  class { 'psad::config':
    options => $options,
    autodl => $autodl,
    commands => $commands,
  }

  class { 'psad::firewall':
    firewall_enable => $firewall_enable,
    firewall_priority => $firewall_priority,
  }

  class { 'psad::cron':
    cronjob_enable => $cronjob_enable,
  }

  include psad::install, psad::config, psad::service, psad::cron, psad::firewall
}
