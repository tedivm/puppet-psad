class psad::install inherits psad::params {
  package { $psad::install::package:
    ensure => present,
    notify => Exec['psad_signature_update']
  }

  exec { 'psad_signature_update':
    command     => $signature_update_command,
    returns     => [0,1],
    refreshonly => true
  }
}