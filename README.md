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

* This module installs the "psad" package on your system.
* PSAD will add three new chains to the firewall where it will store the hosts
  it is blocking.
* PSAD will, unless told not to, add logging rules to the firewall. This is how
  it knows what scans are occurring.
* This module installs a cronjob that runs daily to update it's signatures.
  This cronjob is scheduled using the fqdn_random function and will occur at
  different times for different nodes.
* This module requires mail functions for notification- with most package
  managers this means PSAD will also install a mailer if you have not done so
  already, so it is highly advisable that you configure that separately.
* PSAD will block IP addresses from accessing the wrong ports on systems, and
  this would lead to potential lockouts so make sure to whitelist important
  hosts.


### Setup Requirements **OPTIONAL**

A properly configured firewall is a must- all allowed destinations should be
explicitly placed into the firewall rules.

A mailer of some variety is required to send notifications.


### Beginning with psad

The very basic steps needed for a user to get the module up and running.

If your most recent release breaks compatibility or requires particular steps
for upgrading, you may wish to include an additional section here: Upgrading
(For an example, see http://forge.puppetlabs.com/puppetlabs/firewall).

## Usage

Put the classes, types, and resources for customizing, configuring, and doing
the fancy stuff with your module here.

## Reference

Here, list the classes, types, providers, facts, etc contained in your module.
This section should include all of the under-the-hood workings of your module so
people know what the module is touching on their system but don't need to mess
with things. (We are working on automating this section!)

## Limitations

This is where you list OS compatibility, version compatibility, etc.

## Development

Since your module is awesome, other users will want to play with it. Let them
know what the ground rules for contributing are.

## Release Notes/Contributors/Etc **Optional**

If you aren't using changelog, put your release notes here (though you should
consider using changelog). You may also add any additional sections you feel are
necessary or important to include here. Please use the `## ` header.
