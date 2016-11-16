# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'yankee_score/version'

Gem::Specification.new do |spec|
  spec.name          = "yankee_score"
  spec.version       = YankeeScore::VERSION
  spec.authors       = ["Shmuwol"]
  spec.email         = ["shmullywolfson@gmail.com"]

  spec.summary       = %q{CLI Gem for the New York Yankee's Score}
  spec.description   = %q{}
  spec.homepage      = "https://github.com/Shmuwol/yankee_score"
  spec.license       = "MIT"

  # Prevent pushing this gem to RubyGems.org by setting 'allowed_push_host', or
  # delete this section to allow pushing this gem to any host.
  if spec.respond_to?(:metadata)
    spec.metadata['allowed_push_host'] = "https://rubygems.org"
  else
    raise "RubyGems 2.0 or newer is required to protect against public gem pushes."
  end

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "bin"
  spec.executables   = "yankee_score"
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.11"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
  spec.add_development_dependency "activesupport", "~> 4.2", ">= 4.2.6"


end
