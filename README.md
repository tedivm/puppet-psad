# psad

#### Table of Contents

1. [Overview](#overview)
2. [Module Description - What the module does and why it is useful](#module-description)
3. [Setup - The basics of getting started with psad](#setup)
    * [What psad affects](#what-psad-affects)
    * [Setup requirements](#setup-requirements)
    * [Beginning with psad](#beginning-with-psad)
4. [Usage - Configuration options and additional functionality](#usage)
5. [Reference - An under-the-hood peek at what the module is doing and how](#reference)
5. [Limitations - OS compatibility, etc.](#limitations)
6. [Development - Guide for contributing to the module](#development)
7. [Release notes - Who built this and where to find updates](#release-notes)


## Overview

This module blocks port scans from occurring by installing and configuring
PSAD, the port scan active defense application. The module works for Puppet 3+
and is currently tested on Debian and Ubuntu (more to come!).


## Module Description

PSAD is a staple of system security. It integrates with your existing firewall
to detect traffic to unauthorized ports and block them at their source. In
addition PSAD uses special signatures to detect attack types that occur.

Although PSAD has a variety of configurations to customize it's behavior, the
real value in PSAD is in how it works with your existing firewall. To whitelist
a new range of IPs in PSAD you simply whitelist them in your firewall directly.
For these reasons a propery configured firewall is vital, although this module
will take care of adding it's own required rules in.


## Setup

### What psad affects

* Installs PSAD package.
* Updates psad.conf and autold files.
* Enables PSAD service.
* Adds three new chains to firewall.
* Adds logging rules to firewall.
* Adds cronjob for daily signature updates.
* Requires mailer for notifications and may install one if not present.
* Will block addresses from attempted port scans.


### Setup Requirements

A properly configured firewall is a must -- all allowed destinations should be
explicitly placed into the firewall rules or traffic to them could result in
blocked hosts.

A mailer of some variety is required to send notifications. With most package
managers this means PSAD will also install a mailer if you have not done so
already, so it is highly advisable that you configure that separately.


### Beginning with psad

The simplest way to get started is to simple include the "psad" class.

```puppet
include psad
```

You can also pass parameters for custom behavior.

```puppet
class { 'psad' :
  $config => {
    email_addresses => ['root@localhost.com', 'security@example.com']
  },
  firewall_priorty => 850
}
```


## Usage

All interaction with the psad module can do be done through the main psad class.


### How do I set up the firewall for PSAD?

PSAD inserts logging rules into the system firewall and then keeps track of
what machines are hitting that logging point to build it's database of threats.
All allowed rules must be higher in the chain than the logging rule.


### I just want PSAD, what's the minimum I need?

After setting up your firewall simply include the PSAD class.

```puppet
include psad
```

### What if the PSAD in my repo is old, and I want a newer one?

Install your package before the PSAD class, and set `manage_package => false`:

```puppet
include psad
file { $psad_package_local_filename :
  source => $psad_package_source_url,
}
-> package { $psad::package :
  source => $psad_package_local_filename,
}
-> Class { 'psad' :
  manage_package => false,
}
```

### How do I change the destination for email notifications?

```puppet
class { 'psad' :
  config => {
    email_addresses => ['root@localhost.com', 'security@example.com']
  }
}
```

This can also be configured using Hiera.

```yaml
# Common.yaml
psad::config:
  email_addresses:
    - 'root@localhost.com'
```

```yaml
# DatacenterA.yaml
psad::config:
  email_addresses:
    - 'security@example.com'
```

### How do I block attackers?

In Puppet:
```puppet
class { 'psad' :
  config => {
    enable_auto_ids => 'Y'
  }
}
```

In Hiera:
```yaml
psad::config:
  enable_auto_ids: 'Y'
```



### Can I whitelist or blacklist hosts?

The autodl parameter allows you to set danger levels for specific addresses,
protocols and ports.


```puppet
class { 'psad' :
  autodl => {
    "127.0.0.1" => {
      'level' => 0
    },
    "192.0.2.34" => {
      'level' => 5
    },
    "203.0.113.0/24" => {
      'level' => 5,
      'proto' => 'tcp'
    },
  }
}
```


Using Hiera you can split your configurations up into different files.

```yaml
# Common.yaml
psad::autodl:
  '127.0.0.1':
    level: '0'
```

```yaml
# DatacenterA.yaml
psad::autodl:
  '192.0.2.34':
    level: '5'
```

```yaml
#DatacenterB.yaml
psad::autodl:
  '203.0.113.0/24':
    level: '5'
    proto: 'tcp'
```


### How do I change the priority of the logging rules?

In Puppet:
```puppet
class { 'psad' :
  firewall_priority => 850
}
```

In Hiera:
```yaml
psad::firewall_priority: 850
```

### What if I want to add the logging rules in myself?

In Puppet:
```puppet
class { 'psad' :
  firewall_enable => false
}
```

In Hiera:
```yaml
psad::firewall_enable: false
```

### How does blocking work?

PSAD adds hosts that meet the criteria for blocking using firewall rules. The
length of time a host is blocked depends on it's "danger level", which is
calculated using SNORT rules and by counting how many packets they've sent to
closed ports.

This module comes with some default values to be used as a starting point.

| Danger Level | Ports Scanned | Time Blocked |
| :----------- | :------------ | :----------- |
| 0            | 0             | 0            |
| 1            | 5             | 300          |
| 2            | 50            | 3600         |
| 3            | 150           | 21600        |
| 4            | 1500          | 86400        |
| 5            | 10000         | Permanently  |


### Users keep getting blocked from my mail servers!

Some applications, such as Thunderbird, try to be "helpful" by autoconfiguring
themselves. For mail clients like Thunderbird this can involve attempting to
connect to different ports associated with the domain of the email address it
is trying to configure, and if those ports are not open it can look like a port
scan. Consider whitelisting those particular ports setting the IGNORE_PORTS
value.


In Puppet:
```puppet
class { 'psad' :
  config => {
    ignore_ports => ['tcp/25', 'tcp/113']
  }
}
```

In Hiera:
```yaml
psad::config:
  ignore_ports:
    - 'tcp/25'
    - 'tcp/113'
```

### I'm locked out of my machine!

Find someone who *isn't* locked out and have them run "psad -F" as root. Then
whitelist your machine.


## Reference

### Classes

####Public Classes

* psad: Main class, includes all other classes.

####Private Classes

* psad::config: Handles the configuration and autold files.
* psad::cron: Handles the signature update cronjob.
* psad::firewall: Handles the firewall logging rules.
* psad::install: Handles the installation of PSAD.
* psad::params: Contains variables and defaults used throughout the module.
* psad::service: Handles the PSAD service.


### Parameters

| Parameter           | Type    | Default       |
| :--------------     | :------ |:------------- |
| config              | hash    | PSAD Config   |
| autodl              | hash    | Empty         |
| commands            | hash    | OS Specific   |
| firewall_enable     | bool    | true          |
| firewall_priority   | int     | 895           |
| cronjob_enable      | bool    | true          |


####`config`

Set specific PSAD values to override PSAD defaults in it's config file. Each
value here comes directly from the
[PSAD Configuration](http://cipherdyne.org/psad/docs/config.html).


####`autodl`

Set automatic danger levels for specific hosts, protocols and ports. Danger
levels of 0 act as a whitelist, while levels of 5 will result in the host being
blocked.


####`commands`

Set location of dependent binary if they're in nonstandard locations.


####`firewall_enable`

Set this to add the logging rules to the firewall.


####`firewall_priority`

Set this to change the priority of the logging rules in the firewall.


####`cronjob_enable`

Set this to add a cronjob to update PSADs signatures daily.


## Limitations

This module has been built on and tested against Puppet 3.4 and higher.

The module has been tested on:

* Debian
* Ubuntu


## Development

Contributions are always welcome! Please visit this module's home on
[Github](https://github.com/tedivm/puppet-psad).


## Release Notes

This package is maintained by Robert Hafner. Notices and updates can be found
on [his blog](http://blog.tedivm.com).
