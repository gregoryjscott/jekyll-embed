# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'jekyll/embed/version'

Gem::Specification.new do |spec|

  spec.name          = 'jekyll-embed'
  spec.version       = Jekyll::Embed::VERSION
  spec.authors       = ['Greg Scott']
  spec.email         = ['i@gregoryjscott.com']
  spec.summary       = %q{Uses hypermedia to build Jekyll page data.}
  spec.homepage      = 'https://github.com/gregoryjscott/jekyll-embed'
  spec.license       = 'MIT'

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler', '~> 1.7'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'jekyll', '~> 2.5'

end
