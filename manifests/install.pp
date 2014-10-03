class psad::install inherits psad::params {
  package { "psad":
    ensure => present
  }
}