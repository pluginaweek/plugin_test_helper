# Make sure our default RAILS_ROOT from the helper plugin is in the load path
unless defined?(HELPER_RAILS_ROOT)
  HELPER_RAILS_ROOT = "#{File.dirname(__FILE__)}/../generators/plugin_test_structure/templates/app_root"
end
$:.unshift(HELPER_RAILS_ROOT)

# Determine the plugin's root test directory and add it to the load path
unless defined?(RAILS_ROOT)
  root_path = File.join(File.expand_path('.'), 'test/app_root')
  
  unless RUBY_PLATFORM =~ /(:?mswin|mingw)/
    require 'pathname'
    root_path = Pathname.new(root_path).cleanpath(true).to_s
  end
  
  RAILS_ROOT = root_path
end
$:.unshift(RAILS_ROOT)

# Set the default environment to sqlite3's in_memory database
ENV['RAILS_ENV'] ||= 'in_memory'

# Load the default framework libraries
require 'config/boot'
require 'active_support'
require 'action_controller'

# Load extensions for helping determine where certain environment files are
# located
require 'plugin_test_helper/generator'
require 'plugin_test_helper/extensions/initializer'
require 'plugin_test_helper/extensions/routing'

# Load the Rails environment and testing framework
require_or_load 'config/environment'
require_or_load 'test_help'

# Undo changes to RAILS_ENV
silence_warnings { RAILS_ENV = ENV['RAILS_ENV'] }

# Set default fixture loading properties
class Test::Unit::TestCase #:nodoc:
  self.use_transactional_fixtures = true
  self.use_instantiated_fixtures  = false
end
