# since the psad service returns output in the form of statistics, instead of the default 'exit 0', we need an alternative to check if it is running
# the status check below checks if the psad service is running using 'ps aux'; using grep it finds any processes named psad, but filters out the grep process itself (using the brackets [])
# the exit code for the grep process is used to determine if the service is running or not
# the restart command is also custom, since by default it restarts using /usr/sbin/psad restart, but this will fail with exit code 1 if psad is already running
class psad::service inherits psad::params {
    service { 'psad':
        ensure      => running,
        hasstatus   => true,
        hasrestart  => true,
        enable      => true,
        path        => '/bin:/sbin:/usr/bin:/usr/sbin',
        status      => 'ps aux | grep "[p]sad"',
        restart     => 'psad -R',
        require     => Class["psad::config"],
    }

}
