# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'faraday/http_error/version'

Gem::Specification.new do |spec|
  spec.name          = 'faraday-http_error'
  spec.version       = Faraday::HttpError::VERSION
  spec.authors       = ['Bidu Developers']
  spec.email         = ['dev@bidu.com.br']
  spec.summary       = %q(Faraday HTTP errors)
  spec.description   = %q(faraday middleware to launch http exceptions for 4xx and 5xx status codes)

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ['lib']

  spec.add_runtime_dependency 'faraday', '~> 0.9'
  spec.add_runtime_dependency 'faraday_middleware', '~> 0.9'

  spec.add_development_dependency 'bundler', '~> 1.6'
  spec.add_development_dependency 'rake'
  spec.add_development_dependency 'rspec', '~> 2.14'
end
