class psad::cron inherits psad::params {
  cron { 'psad_sigupdates':
    command  => $signature_update_command,
    user     => root,
    hour     => fqdn_rand(23, 'psad cron hour'),
    minute   => fqdn_rand(59, 'psad cron minute'),
    month    => '*',
    monthday => '*',
    weekday  => '*',
    require  => Class['psad::config']
  }
}


