$LOAD_PATH.unshift File.expand_path('../lib', __FILE__)
require 'plugin_test_helper/version'

Gem::Specification.new do |s|
  s.name              = "plugin_test_helper"
  s.version           = PluginTestHelper::VERSION
  s.authors           = ["Aaron Pfeifer"]
  s.email             = "aaron@pluginaweek.org"
  s.homepage          = "http://www.pluginaweek.org"
  s.description       = "Simplifies plugin testing by creating an isolated Rails environment that simulates its usage in a real application."
  s.summary           = "Simple Rails plugin testing"
  s.require_paths     = ["lib"]
  s.files             = `git ls-files`.split("\n")
  s.test_files        = `git ls-files -- test/*`.split("\n")
  s.rdoc_options      = %w(--line-numbers --inline-source --title plugin_test_helper --main README.rdoc)
  s.extra_rdoc_files  = %w(README.rdoc CHANGELOG.rdoc LICENSE)
  
  s.add_dependency("rails", "= 2.3.8")
  s.add_dependency("sqlite3-ruby", "~> 1.3.0")
  s.add_development_dependency("rake")
end
