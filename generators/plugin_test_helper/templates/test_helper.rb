# If you want to change the default rails environment
# ENV['RAILS_ENV'] ||= 'your_env'

# Load the plugin testing framework
require 'rubygems'
require 'plugin_test_helper'

# Run the migrations (optional)
ActiveRecord::Migrator.migrate("#{RAILS_ROOT}/db/migrate")