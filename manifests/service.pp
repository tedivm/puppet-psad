class psad::service {
  service { "psad":
    ensure => running,
    hasstatus => true,
    hasrestart => true,
    enable => true,
    require => Class["psad::config"]
  }
}