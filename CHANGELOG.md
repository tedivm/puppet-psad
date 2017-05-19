##2017-05-18 - Release 1.2.1

### Summary

This is a bugfix release.


##2017-05-18 - Release 1.2.0

### Summary

This release focuses on cross compatibility and improving the defaut settings.

#### Features

- Automatically selects the best options for Redhat and Debian family systems.

- Signature updates now occur using SSL instead of HTTP.

- The default value of "enable_auto_ids" has been switched to off, requiring
  users to explicitly turn on blocking. This way they can test first and check
  through the PSAD logs for any errors.

- The default auto_dl has been set to level two, which is a little more lenient than
  level one.

- The default packet number for level two has been set to 50, from 15.

- The default blocking time for level one is now five minutes.

- New configuration options for later versions of PSAD are supported.


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
