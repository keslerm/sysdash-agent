# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'sysdash/agent/version'

Gem::Specification.new do |spec|
  spec.name          = "sysdash-agent"
  spec.version       = Sysdash::Agent::VERSION
  spec.authors       = ["Morgan Kesler"]
  spec.email         = ["keslerm@dasbiersec.com"]

  spec.summary       = "Agent for Sysdash to report heartbeats and messages"
  spec.description   = "Agent for Sysdash to report heartbeats and messages"
  spec.homepage      = "https://github.com/keslerm/sysdash-agent"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency "bundler"
  spec.add_dependency "rake"
  spec.add_dependency "rest-client"
  spec.add_dependency "usagewatch"
  spec.add_dependency "ohai"
  spec.add_dependency "sys-cpu"
end
