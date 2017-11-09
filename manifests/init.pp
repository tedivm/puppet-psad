# == Class: psad
#
# PSAD is a staple of system security. It integrates with your existing
# firewall to detect traffic to unauthorized ports and block them at their
# source. In addition PSAD uses special signatures to detect attack types that
# occur.
#
# Although PSAD has a variety of configurations to customize it's behavior, the
# real value in PSAD is in how it works with your existing firewall. To
# whitelist a new range of IPs in PSAD you simply whitelist them in your
# firewall directly. For these reasons a propery configured firewall is vital,
# although this module will take care of adding it's own required rules in.
#
# === Parameters
#
# [*config*]
#   Set specific PSAD values to override PSAD defaults in it's config file.
#   Each value here comes directly from the PSAD Configuration.
#
# [*autodl*]
#   Set automatic danger levels for specific hosts, protocols and ports. Danger
#   levels of 0 act as a whitelist, while levels of 5 will result in the host being blocked.
#
# [*commands*]
#   Set location of dependent binary if they're in nonstandard locations.
#
# [*firewall_enable*]
#   Set this to add the logging rules to the firewall.
#
# [*firewall_priority*]
#   Set this to change the priority of the logging rules in the firewall.
#
# [*cronjob_enable*]
#   Set this to add a cronjob to update PSADs signatures daily.
#
# [*manage_package*]
#   Set this to false if you want to manage installation of the psad package separately.
#
# === Examples
#
#  class { 'psad' :
#    config => {
#      'email_addresses' => ['root@localhost.com', 'security@example.com']
#    },
#    firewall_priority => 850,
#    cronjob_enable => true,
#  }
#
#
# === Authors
#
# Robert Hafner <tedivm@tedivm.com>
#
# === Copyright
#
# Copyright 2014 Robert Hafner
#
class psad (
  $config = {},
  $autodl = {},
  $commands = {},
  $firewall_enable = true,
  $firewall_priority = 895,
  $cronjob_enable = true,
  $manage_package = true,
) inherits psad::params {

  class { 'psad::install':
    require => Class['psad::firewall']
  }

  class { 'psad::config':
    config   => $config,
    autodl   => $autodl,
    commands => $commands,
  }

  class { 'psad::firewall':
    firewall_enable   => $firewall_enable,
    firewall_priority => $firewall_priority,
  }

  class { 'psad::cron':
    cronjob_enable => $cronjob_enable,
  }

  include psad::install, psad::config, psad::service, psad::cron, psad::firewall
}
