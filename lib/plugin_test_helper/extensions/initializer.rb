require 'active_support'
require 'plugin_test_helper/plugin_locator'

module PluginAWeek #:nodoc:
  module PluginTestHelper
    module Extensions #:nodoc:
      # Adds in hooks for extending other parts of the Rails framework *after*
      # Rails has loaded those frameworks
      module Initializer
        def self.included(base)
          base.class_eval do
            alias_method_chain :require_frameworks, :test_helper
          end
        end
        
        # Load the needed frameworks and then our extensions to them
        def require_frameworks_with_test_helper
          require_frameworks_without_test_helper
          
          require 'plugin_test_helper/generator'
          require 'plugin_test_helper/extensions/routing'
        end
      end
      
      # Overrides some of the default values in the Rails configuration so that
      # files can be reused from this test helper or overridden by the plugin
      # using the helper
      module Configuration
        def self.included(base) #:nodoc:
          base.class_eval do
            alias_method_chain :environment_path, :test_helper
            alias_method_chain :default_load_paths, :test_helper
            alias_method_chain :default_database_configuration_file, :test_helper
            alias_method_chain :default_controller_paths, :test_helper
            alias_method_chain :default_plugin_locators, :test_helper
            alias_method_chain :default_plugin_paths, :test_helper
          end
        end
        
        # Load the environment file from the plugin or the helper
        def environment_path_with_test_helper
          environment_path = environment_path_without_test_helper
          File.exists?(environment_path) ? environment_path : "#{HELPER_RAILS_ROOT}/config/environments/#{environment}.rb"
        end
        
        private
          # Add the helper's load paths
          def default_load_paths_with_test_helper
            paths = default_load_paths_without_test_helper
            paths.concat %w(
              app
              app/controllers
              config
              lib
              vendor
            ).map {|dir| "#{HELPER_RAILS_ROOT}/#{dir}"}
          end
          
          # Load the database configuration from the plugin or the helper
          def default_database_configuration_file_with_test_helper
            database_file = default_database_configuration_file_without_test_helper
            File.exists?(database_file) ? database_file : File.join(HELPER_RAILS_ROOT, 'config/database.yml')
          end
          
          # Add the helper's controllers path
          def default_controller_paths_with_test_helper
            paths = default_controller_paths_without_test_helper
            paths << File.join(HELPER_RAILS_ROOT, 'app/controllers')
          end
          
          # Adds a custom plugin locator for loading the plugin being tested
          def default_plugin_locators_with_test_helper
            locators = default_plugin_locators_without_test_helper
            locators.unshift(PluginAWeek::PluginTestHelper::PluginLocator)
          end
          
          # Add the helper's vendor/plugins path
          def default_plugin_paths_with_test_helper
            paths = default_plugin_paths_without_test_helper
            paths << File.join(HELPER_RAILS_ROOT, '/vendor/plugins')
          end
      end
    end
  end
end

Rails::Initializer.class_eval do
  include PluginAWeek::PluginTestHelper::Extensions::Initializer
end

Rails::Configuration.class_eval do
  include PluginAWeek::PluginTestHelper::Extensions::Configuration
end
