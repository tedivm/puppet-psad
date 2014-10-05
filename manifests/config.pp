class psad::config(
  $options = {},
  $autodl = {},
  $commands = {},
  $firewall_enable = true,
  $firewall_priority = 895
) inherits psad::params {

  $merged_options = merge($psad::params::psad_default_options, hiera_hash('psad::options', {}), $options)
  $merged_autodl = merge($psad::params::psad_default_autodl, hiera_hash('psad::autodl', {}), $autodl)
  $merged_commands = merge($psad::params::psad_default_commands, hiera_hash('psad::commands', {}), $commands)
  $firewall_priority_final = hiera('psad::firewall_priority', $firewall_priority)
  $firewall_enable_final = hiera('psad::firewall_enable', $firewall_enable)


  File {
    ensure => present,
    owner => 'root',
    group => 'root',
    mode => '0600',
    require => Class["psad::install"],
    notify => Class["psad::service"]
  }

  file {"/etc/psad/psad.conf":
    content => template('psad/psad.conf.erb'),
  }

  file {"/etc/psad/auto_dl":
    content => template('psad/auto_dl.erb'),
  }

  if($firewall_enable == true) {
    firewall { "${firewall_priority_final} log dropped input chain":
      chain => 'INPUT',
      log_level => '6',
      log_prefix => '[IPTABLES INPUT] dropped ',
      jump => 'LOG'
    }

    firewall { "${firewall_priority_final} log dropped forward chain":
      chain => 'FORWARD',
      log_level => '6',
      log_prefix => '[IPTABLES INPUT] dropped ',
      jump => 'LOG'
    }
  }
}