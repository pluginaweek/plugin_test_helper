module PluginTestHelper
  class Initializer < Rails::Initializer
    def self.run(command = :process, configuration = Configuration.new)
      yield configuration if block_given?
      initializer = new configuration
      initializer.send(command)
      initializer
    end
  end

  class Configuration < Rails::Configuration
    # The path to the current environment's file (development.rb, etc.). By
    # default the file is at <tt>config/environments/#{environment}.rb</tt>.
    def environment_path
      "#{root_path}/config/environments/#{environment}.rb"
    end

      def default_load_paths
        paths = ["#{root_path}/test/mocks/#{environment}"]

        # Add the app's controller directory
        paths.concat(Dir["#{root_path}/app/controllers/"])

        # Then components subdirectories.
        paths.concat(Dir["#{root_path}/components/[_a-z]*"])

        # Followed by the standard includes.
        paths.concat %w(
          app
          app/models
          app/controllers
          app/helpers
          app/services
          app/apis
          components
          config
          lib
          vendor
        ).map { |dir| "#{root_path}/#{dir}" }.select { |dir| File.directory?(dir) }

        paths.concat builtin_directories
      end

      def default_database_configuration_file
        File.join(root_path, 'config', 'database.yml')
      end

      def default_controller_paths
        paths = [ File.join(root_path, 'app', 'controllers'), File.join(root_path, 'components') ]
        paths.concat builtin_directories
        paths
      end
  end
end