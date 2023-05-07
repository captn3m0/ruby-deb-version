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

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(__dir__) do
    `git ls-files -z`.split("\x0").reject do |f|
      (File.expand_path(f) == __FILE__) || f.start_with?(*%w[bin/ test/ spec/ features/ .git all-debian-versions.lst test.rb])
    end
  end
  
  spec.require_paths = ["lib"]

  spec.add_development_dependency "rake", "~> 13.0"
  spec.add_development_dependency "rubocop", "~> 1.21"
  spec.add_development_dependency "minitest", "~> 5.18"
  spec.add_development_dependency "rubocop-minitest", "~> 0.31.0"
  spec.add_development_dependency "rubocop-rake", "~> 0.6.0"

  spec.metadata["rubygems_mfa_required"] = "true"
end
