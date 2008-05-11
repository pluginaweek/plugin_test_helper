module PluginAWeek #:nodoc:
  module PluginTestHelper
    module Extensions #:nodoc:
      # Overrides where the path of the application routes is located so that
      # it defaults to this helper's implementation or can be overridden by the
      # plugin using this helper
      module Routing
        def self.included(base)
          base.class_eval do
            alias_method_chain :reload, :test_helper
            alias_method_chain :load_routes!, :test_helper
          end
        end
        
        # Load routes from either the helper or the plugin
        def reload_with_test_helper
          if @routes_last_modified && defined?(Rails.root)
            routes_path = File.join("#{Rails.root}/config/routes.rb")
            routes_path = File.join("#{HELPER_RAILS_ROOT}/config/routes.rb") unless File.exists?(routes_path)
            
            mtime = File.stat(routes_path).mtime
            # if it hasn't been changed, then just return
            return if mtime == @routes_last_modified
            # if it has changed then record the new time and fall to the load! below
            @routes_last_modified = mtime
          end
          load!
        end
        
        # Load routes from either the helper or the plugin
        def load_routes_with_test_helper!
          if defined?(Rails.root) && defined?(::ActionController::Routing::Routes) && self == ::ActionController::Routing::Routes
            routes_path = File.join("#{Rails.root}/config/routes.rb")
            routes_path = File.join("#{HELPER_RAILS_ROOT}/config/routes.rb") unless File.exists?(routes_path)
            
            load File.join(routes_path)
            @routes_last_modified = File.stat(routes_path).mtime
          else
            add_route ":controller/:action/:id"
          end
        end
      end
    end
  end
end

ActionController::Routing::RouteSet.class_eval do
  include PluginAWeek::PluginTestHelper::Extensions::Routing
end
