##2015-01-07 - Release 1.1.2

### Summary

This release focuses on code quality improvements and service robustness.

#### Features

- Improved handling of PSAD status checks.
- Code Formatting Improvements based around puppet-lint.
- Fleshed out comments in the PSAD class.



##2014-10-09 - Release 1.1.0

### Summary

This update takes into account user feedback and adds better support for IPv6.

#### Features

- Further improved handling of array values in PSAD configuration.
- Rewrote templates using community suggested best practices.
- Added logging for IPv6 firewalls.
- Reworked class dependencies to prevent PSAD error email on first run.


#### Backwards-incompatible Changes:

- Tightened up default settings to ensure that blocking works out of the box.



##2014-10-06 - Release 1.0.0

### Summary

This is the first stable release of this module. This update primarily updated
documentation.

#### Features

- Improved handling of array values in PSAD configuration.

#### Backwards-incompatible Changes:

- Changed the `options` parameter to `config` in the PSAD class.