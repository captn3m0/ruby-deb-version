# frozen_string_literal: true

require_relative "lib/deb_version/version"

Gem::Specification.new do |spec|
  spec.name = "deb_version"
  spec.version = DebVersion::VERSION
  spec.authors = ["Nemo"]
  spec.email = ["rubygem@captnemo.in"]

  spec.summary = "A port of Debian Version comparison to Ruby."
  spec.homepage = "https://github.com/captn3m0/ruby-deb-version"
  spec.license = "MIT"
  spec.required_ruby_version = ">= 3.0.0"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://github.com/captn3m0/ruby-deb-version"
  spec.metadata["changelog_uri"] = "https://github.com/captn3m0/ruby-deb-version/blob/main/README.md"

  spec.files = Dir["lib/**/*", "CHANGELOG.md", "README.md", "LICENSE.txt", "bin/*"]

  spec.require_paths = ["lib"]

  spec.metadata["rubygems_mfa_required"] = "true"
end
