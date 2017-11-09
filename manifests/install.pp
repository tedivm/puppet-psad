class psad::install {
  include psad
  package { $psad::package:
    ensure => present,
    notify => Exec['psad_signature_update']
  }

  exec { 'psad_signature_update':
    command     => $psad::signature_update_command,
    returns     => [0,1],
    refreshonly => true
  }
}
