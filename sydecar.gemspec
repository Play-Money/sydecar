# frozen_string_literal: true

require_relative "lib/sydecar/version"

Gem::Specification.new do |spec|
  spec.name = "sydecar"
  spec.version = Sydecar::VERSION
  spec.authors = ["1lyan"]
  spec.email = ["ilya.nechiporenko@gmail.com"]

  spec.summary = "Ruby bindings for the Sydecar API."
  spec.description = "Ruby bindings for the Sydecar API."
  spec.homepage = "https://github.com/Play-Money/sydecar."
  spec.license = "MIT"
  spec.required_ruby_version = ">= 2.6.0"

  spec.metadata["allowed_push_host"] = "TODO: Set to your gem server 'https://example.com'"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = spec.homepage
  spec.metadata["changelog_uri"] = spec.homepage

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(__dir__) do
    `git ls-files -z`.split("\x0").reject do |f|
      (f == __FILE__) || f.match(%r{\A(?:(?:bin|test|spec|features)/|\.(?:git|travis|circleci)|appveyor)})
    end
  end
  spec.bindir = "exe"
  spec.executables = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  # Uncomment to register a new dependency of your gem
  # spec.add_dependency "example-gem", "~> 1.0"

  # For more information and examples about making a new gem, check out our
  # guide at: https://bundler.io/guides/creating_gem.html

  spec.add_development_dependency 'webmock', '~> 3.18'
  spec.add_development_dependency 'activesupport', '~> 7.0'
  spec.add_development_dependency 'faraday-logging-color_formatter', '~> 0.2.0'
  spec.add_development_dependency 'rspec', '~> 3.0'
  spec.add_development_dependency 'byebug', '~> 11.1'
  spec.add_development_dependency 'awesome_print', '~> 1.9'

  spec.add_dependency 'faraday', '~> 2.7'
  spec.add_dependency 'json', '~> 2.6'
  spec.add_dependency 'faraday-multipart', '~> 1.0'
end
