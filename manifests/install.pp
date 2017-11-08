class psad::install inherits psad::params {
  package { $psad::install::package:
    ensure => present,
    notify => Exec['psad_signature_update']
  }

  exec { 'psad_signature_update':
    command     => $sig_update_cmd,
    returns     => [0,1],
    refreshonly => true
  }
}