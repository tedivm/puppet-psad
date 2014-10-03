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
    content => template('psad/psad.conf.erb'),
  }

  file {"/etc/psad/auto_dl":
    content => template('psad/auto_dl.erb'),
  }
}