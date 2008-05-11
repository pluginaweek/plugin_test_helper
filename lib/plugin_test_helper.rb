# Make sure our default RAILS_ROOT from the helper plugin is in the load path
HELPER_RAILS_ROOT = "#{File.dirname(__FILE__)}/../generators/plugin_test_structure/templates/app_root" unless defined?(HELPER_RAILS_ROOT)
$:.unshift(HELPER_RAILS_ROOT)

# Determine the plugin's root test directory and add it to the load path
RAILS_ROOT = (File.directory?('./test/app_root') ? './test/app_root' : HELPER_RAILS_ROOT) unless defined?(RAILS_ROOT)
$:.unshift(RAILS_ROOT)

# Set the default environment to sqlite3's in_memory database
ENV['RAILS_ENV'] ||= 'in_memory'

# First boost the Rails framework
require 'config/boot'

# Extend it so that we can hook into the initialization process
require 'plugin_test_helper/extensions/initializer'

# Load the Rails environment and testing framework
require_or_load 'config/environment'
require_or_load 'test_help'

# Undo changes to RAILS_ENV
silence_warnings {RAILS_ENV = ENV['RAILS_ENV']}

# Set default fixture loading properties
class Test::Unit::TestCase #:nodoc:
  self.use_transactional_fixtures = true
  self.use_instantiated_fixtures  = false
  self.fixture_path = "#{Rails.root}/../fixtures"
end
