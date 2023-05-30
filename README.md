# Debian Version (Ruby) [![License MIT](https://badgen.net/github/license/captn3m0/ruby-deb-version)](https://github.com/captn3m0/ruby-deb-version/blob/main/LICENSE.txt) [![Rubygems version](https://badgen.net/rubygems/v/deb_version)](https://rubygems.org/gems/deb_version) [![CI Status](https://badgen.net/github/checks/captn3m0/ruby-deb-version)](https://github.com/captn3m0/ruby-deb-version/actions/workflows/main.yml?query=branch%3Amain) ![Latest Tag](https://badgen.net/github/tag/captn3m0/ruby-deb-version) [![Open Issues](https://badgen.net/github/open-issues/captn3m0/ruby-deb-version)](https://github.com/captn3m0/ruby-deb-version/issues?q=is%3Aissue+is%3Aopen)

A port of "Debian Version" comparison function to Ruby. This is based on 
[Debian Policy Manual v4.6.20, Section 5.6.12](https://www.debian.org/doc/debian-policy/ch-controlfields.html#version).

It adapts some of the code from https://github.com/FauxFaux/deb-version and https://github.com/xolox/python-deb-pkg-tools

## Installation

Install the gem and add to the application's Gemfile by executing:

    $ bundle add deb_version

If bundler is not being used to manage dependencies, install the gem by executing:

    $ gem install deb_version

## Usage

```ruby
require 'deb_version'
v1 = DebVersion.new("1.3~rc2")
v2 = DebVersion.new("1.3")
v1 < v2 # true
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and the created tag, and push the `.gem` file to [rubygems.org](https://rubygems.org).

Run `bundle exec rake rubocop` to check for style violations.

Run `bundle exec rake test` to run tests.

See [HACKING.md](HACKING.md) for further details.

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/captn3m0/ruby-deb-version. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [code of conduct](https://github.com/captn3m0/ruby-deb-version/blob/main/CODE_OF_CONDUCT.md).

## License

The gem is available as open source under the terms of the [MIT License](https://nemo.mit-license.org/).

## Code of Conduct

Everyone interacting in the DebVersion project's codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/captn3m0/ruby-deb-version/blob/main/CODE_OF_CONDUCT.md).
