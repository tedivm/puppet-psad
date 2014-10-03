class psad::install inherits psad::params {
  package { $psad::install::package:
    ensure => present
  }
}