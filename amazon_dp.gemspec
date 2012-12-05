# -*- encoding: utf-8 -*-
require File.expand_path('../lib/amazon_dp/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["kimoto"]
  gem.email         = ["sub+peerler@gmail.com"]
  gem.description   = %q{Amazon Description of Product page parser}
  gem.summary       = %q{Amazon Description of Product page parser}
  gem.homepage      = ""

  gem.files         = `git ls-files`.split($\)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.name          = "amazon_dp"
  gem.require_paths = ["lib"]
  gem.version       = AmazonDP::VERSION
end
