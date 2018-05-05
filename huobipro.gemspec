
# coding: utf-8

lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'huobipro/version'

Gem::Specification.new do |spec|
  spec.name          = 'huobipro'
  spec.version       = Huobipro::VERSION
  spec.authors       = ['Jason Tai']
  spec.email         = ['taijcjc@gmail.com']

  spec.summary       = 'API Wrapper for the huobipro cryptocurrency exchange.'
  spec.homepage      = 'https://github.com/tjcjc/huobipro'
  spec.license       = 'MIT'

  spec.files         = Dir['bin/*'] +
                       Dir['lib/**/*.rb']

  spec.require_paths = ['lib']

  spec.bindir        = 'bin'

  spec.add_development_dependency 'bundler', '~> 1.15'
  spec.add_development_dependency 'rspec', '~> 3.0'

  spec.add_runtime_dependency 'faraday', '~> 0.12'
  spec.add_runtime_dependency 'faraday_middleware', '~> 0.12'
  spec.add_runtime_dependency 'em-http-request', '~> 1.1.5'
end
