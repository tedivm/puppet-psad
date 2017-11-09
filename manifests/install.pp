class psad::install {
  include psad
  if $psad::manage_package {
    package { $psad::package:
      ensure => present,
    }
  }

  exec { 'psad_signature_update':
    command     => $psad::signature_update_command,
    returns     => [0,1],
    refreshonly => true,
    subscribe   => Package[$psad::package],
  }
}
