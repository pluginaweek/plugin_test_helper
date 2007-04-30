# Load the environment
ENV['RAILS_ENV'] ||= 'in_memory'
require File.dirname(__FILE__) + '/rails_root/config/environment.rb'

# Load the testing framework
require 'test_help'
silence_warnings { RAILS_ENV = ENV['RAILS_ENV'] }

# Get some additional help
require 'dry_validity_assertions'

# Run the plugin migrations
PluginAWeek::PluginMigrations.migrate('acts_as_state_machine')

# Run the migrations
ActiveRecord::Migrator.migrate("#{RAILS_ROOT}/db/migrate")