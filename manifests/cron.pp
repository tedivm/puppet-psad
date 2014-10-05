class psad::cron (
  $cronjob_enable = true
) inherits psad::params {
  if($cronjob_enable == true) {
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
}


