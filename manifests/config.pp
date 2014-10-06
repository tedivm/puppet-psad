class psad::config(
  $config = {},
  $autodl = {},
  $commands = {}
) inherits psad::params {

  $merged_config = merge($psad::params::psad_default_config, hiera_hash('psad::config', {}), $config)
  $merged_autodl = merge($psad::params::psad_default_autodl, hiera_hash('psad::autodl', {}), $autodl)
  $merged_commands = merge($psad::params::psad_default_commands, hiera_hash('psad::commands', {}), $commands)

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