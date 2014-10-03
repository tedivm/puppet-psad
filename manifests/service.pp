class psad::service inherits psad::params {
  service { 'psad':
    ensure => running,
    hasstatus => true,
    hasrestart => true,
    enable => true,
    require => Class["psad::config"]
  }
}