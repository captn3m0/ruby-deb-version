## [1.0.4] - 2026-11-24
- `DebVersion.new` now validates its input and raises `DebVersion::Error`. See #1.
- Versions that were previously accepted but are invalid, such as RPM-style `6.0-4.el6.x86_64`, now raise.
- Ports a few more tests from [go-deb-version](https://github.com/knqyf263/go-deb-version/blob/master/version_test.go)
- CI: tests on Ruby 4.0, rubocop runs once, and actions are pinned with tighter permissions.

## [1.0.3] - 2025-08-25
- Drops Ruby 3.0
- Adds Ruby 3.3, 3.4

## [1.0.2] - 2023-05-30
- Dependency cleanup

## [1.0.1] - 2023-05-30
- Bug fix for versions using `z`
- Adds a new `to_s` method.

## [0.1.0] - 2023-05-07

- Initial release

[1.0.4]: https://github.com/captn3m0/ruby-deb-version/compare/v1.0.3...v1.0.4
[1.0.3]: https://github.com/captn3m0/ruby-deb-version/compare/v1.0.2...v1.0.3
[1.0.2]: https://github.com/captn3m0/ruby-deb-version/compare/v1.0.1...v1.0.2
[1.0.1]: https://github.com/captn3m0/ruby-deb-version/compare/v1.0.0...v1.0.1
[1.0.0]: https://github.com/captn3m0/ruby-deb-version/releases/tag/v1.0.0
[0.1.0]: https://github.com/captn3m0/ruby-deb-version/releases
