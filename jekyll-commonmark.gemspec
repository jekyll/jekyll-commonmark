# frozen_string_literal: true

require_relative "lib/jekyll-commonmark/version"

Gem::Specification.new do |spec|
  spec.name          = "jekyll-commonmark"
  spec.summary       = "CommonMark generator for Jekyll"
  spec.version       = Jekyll::CommonMark::VERSION
  spec.authors       = ["Pat Hawks"]
  spec.email         = "pat@pathawks.com"
  spec.homepage      = "https://github.com/jekyll/jekyll-commonmark"
  spec.licenses      = ["MIT"]

  spec.files         = `git ls-files lib -z`.split("\x0").concat(%w(LICENSE Readme.md History.markdown))
  spec.require_paths = ["lib"]

  spec.required_ruby_version = ">= 2.6.0"

  spec.add_runtime_dependency "commonmarker", "~> 0.23"

  spec.add_development_dependency "bundler"
  spec.add_development_dependency "jekyll", ">= 3.7", "< 5.0"
  spec.add_development_dependency "rake", "~> 12.0"
  spec.add_development_dependency "rspec", "~> 3.0"
  spec.add_development_dependency "rubocop-jekyll", "~> 0.12.0"
end
