class psad::config inherits psad::params {

  File {
    ensure => present,
    owner => 'root',
    group => 'root',
    mode => '0600',
    require => Class["psad::install"],
    notify => Class["psad::service"]
  }

  file {"/etc/psad/psad.conf":
    source => "puppet:///modules/psad/psad.conf",
  }

  file {"/etc/psad/auto_dl":
    source => "puppet:///modules/psad/psad.conf",
  }
}