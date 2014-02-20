# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'undertaker/version'

Gem::Specification.new do |spec|
  spec.name          = "undertaker-rails"
  spec.version       = Undertaker::VERSION
  spec.authors       = ["Brian LaMattina"]
  spec.email         = ["brianlamattina@gmail.com"]
  spec.summary       = %q{Easy exponential back off}
  spec.description   = %q{Easy exponential back off}
  spec.homepage      = "https://github.com/blamattina/undertaker"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.required_ruby_version = Gem::Requirement.new(">= 1.9.2")

  spec.add_dependency("activesupport", ">= 4.0.0")

  spec.add_development_dependency "bundler", "~> 1.5"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec", "~> 2.14.0"
  spec.add_development_dependency "pry", "~> 0.9.12"
end
