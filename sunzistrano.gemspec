# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'sunzistrano/version'

Gem::Specification.new do |spec|
  spec.name          = "sunzistrano"
  spec.version       = Sunzistrano::VERSION
  spec.authors       = ["Patrice Lebel"]
  spec.email         = ["plebel@o2web.ca"]

  spec.summary       = %q{Basic deploy scenario with Capistrano and Sunzi already configured.}
  spec.description   = %q{Basic deploy scenario with Capistrano and Sunzi already configured.}
  # spec.homepage      = "TODO: Put your gem's website or public repo URL here."
  spec.license       = "MIT"

  # Prevent pushing this gem to RubyGems.org by setting 'allowed_push_host', or
  # delete this section to allow pushing this gem to any host.
  # if spec.respond_to?(:metadata)
  #   spec.metadata['allowed_push_host'] = "TODO: Set to 'http://mygemserver.com'"
  # else
  #   raise "RubyGems 2.0 or newer is required to protect against public gem pushes."
  # end

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency 'capistrano', '~> 3.1'
  spec.add_dependency 'capistrano-bundler', '~> 1.1'
  spec.add_dependency 'capistrano-rails', '~> 1.1'
  spec.add_dependency 'capistrano-rbenv', '~> 2.0'
  spec.add_dependency 'capistrano3-nginx', '~> 2.0'
  spec.add_dependency 'capistrano-passenger'

  spec.add_development_dependency "bundler", "~> 1.9"
  spec.add_development_dependency "rake", "~> 10.0"
end
