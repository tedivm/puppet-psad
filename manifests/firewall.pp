class psad::firewall(
  $firewall_enable = true,
  $firewall_priority = 895
) inherits psad::params {

  $firewall_priority_final = hiera('psad::firewall_priority', $firewall_priority)
  $firewall_enable_final = hiera('psad::firewall_enable', $firewall_enable)

  Firewall {
    require  => Class['psad::config']
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