# Make sure our default RAILS_ROOT from the helper plugin is in the load path
HELPER_RAILS_ROOT = "#{File.dirname(__FILE__)}/../generators/plugin_test_structure/templates/app_root"
$:.unshift(HELPER_RAILS_ROOT)

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

# Load the Rails environment and unit testing framework
require 'config/environment'
require 'test/unit'