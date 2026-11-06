# Changelog

## [2.0.0] - 2026-11-06

- **Breaking**: require Ruby 3.3 or newer.
- **Breaking**: all drivers run Chrome with `--force-prefers-reduced-motion`.
- Fix device drivers on Selenium 4, which no longer provides `Remote::Capabilities.chrome` and `desired_capabilities:`.
- Register the Chrome drivers with downloads only once, instead of once per device.
- Release from Semaphore when a version tag is pushed.

## [1.0.0] - 2023-01-25

- Added two new methods `first_download` and `last_download`.
- Added more instructions to the README for Chrome with downloads options, in particular to clean up folders.
- Added an example to read a downloaded file

## [0.2.0] - 2020-06-18

- Add chrome with downloads capabilities to the list of already so many devices

## [0.1.0] - 2020-03-02

- Initial release
