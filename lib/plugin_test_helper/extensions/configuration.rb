require 'plugin_test_helper/plugin_locator'

module PluginTestHelper
  module Extensions #:nodoc:
    # Overrides some of the default values in the Rails configuration so that
    # files can be reused from this test helper or overridden by the plugin
    # using the helper
    module Configuration
      def self.included(base) #:nodoc:
        alias_method_chain base, :environment_path, :test_helper
        alias_method_chain base, :default_load_paths, :test_helper
        alias_method_chain base, :default_database_configuration_file, :test_helper
        alias_method_chain base, :default_routes_configuration_file, :test_helper
        alias_method_chain base, :default_controller_paths, :test_helper
        alias_method_chain base, :default_plugin_locators, :test_helper
      end
      
      # Defines a "lite" version of ActiveSupport's alias chaining extensions.
      # This is defined here and acts on a particular class so as to not conflict
      # with other classes that we have no control over
      def self.alias_method_chain(klass, target, feature)
        with_method, without_method = "#{target}_with_#{feature}", "#{target}_without_#{feature}"
        klass.class_eval do
          alias_method without_method, target
          alias_method target, with_method
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
          ).map {|dir| "#{HELPER_RAILS_ROOT}/#{dir}"}
        end
        
        # Load the database configuration from the plugin or the helper
        def default_database_configuration_file_with_test_helper
          database_file = default_database_configuration_file_without_test_helper
          File.exists?(database_file) ? database_file : File.join(HELPER_RAILS_ROOT, 'config/database.yml')
        end
        
        # Load the routes configuration file from the plugin or the helper
        def default_routes_configuration_file_with_test_helper
          routes_file = default_routes_configuration_file_without_test_helper
          File.exists?(routes_file) ? routes_file : File.join(HELPER_RAILS_ROOT, 'config/routes.rb')
        end
        
        # Add the helper's controllers path
        def default_controller_paths_with_test_helper
          paths = default_controller_paths_without_test_helper
          paths << File.join(HELPER_RAILS_ROOT, 'app/controllers')
        end
        
        # Adds a custom plugin locator for loading the plugin being tested
        def default_plugin_locators_with_test_helper
          locators = default_plugin_locators_without_test_helper
          locators.unshift(PluginTestHelper::PluginLocator)
        end
    end
  end
end

Rails::Configuration.class_eval do
  include PluginTestHelper::Extensions::Configuration
end
