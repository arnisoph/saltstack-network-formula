# network-formula

Salt Stack Formula to set up and configure a host's network configuration

## NOTICE BEFORE YOU USE

* This formula aims to follow the conventions and recommendations described at [http://docs.saltstack.com/topics/conventions/formulas.html](http://docs.saltstack.com/topics/conventions/formulas.html)

## TODO

* Use more of the available options in interfaces.sls of network.managed
* interfaces: configure broadcast if set

## Instructions

1. Add this repository as a [GitFS](http://docs.saltstack.com/topics/tutorials/gitfs.html) backend in your Salt master config.

2. Configure your Pillar top file (`/srv/pillar/top.sls`), see pillar.example

3. Include this Formula within another Formula or simply define your needed states within the Salt top file (`/srv/salt/top.sls`).

## Available states

### network.hosts

Sets the static lookup table for hostnames

### network.interfaces

Sets the network interfaces configuration

### network.resolver

Sets the resolver configuration

## Additional resources

None

## Formula Dependencies

None

## Contributions

Contributions are always welcome. All development guidelines you have to know are

* write clean code (proper YAML+Jinja syntax, no trailing whitespaces, no empty lines with whitespaces, LF only)
* set sane default settings
* test your code
* update README.md doc

## Salt Compatibility

Tested with:

* 2014.1.0

## OS Compatibility

Tested with:

* GNU/ Linux Debian Wheezy
