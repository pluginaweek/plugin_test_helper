module PluginAWeek #:nodoc:
  module PluginTestHelper #:nodoc:
    module Extensions #:nodoc:
      # Overrides where the path of the application routes is located so that
      # it defaults to this helper's implementation or can be overridden by the
      # plugin using this helper
      module Routing
        def self.included(base)
          base.class_eval do
            alias_method :load_routes!, :load_routes_with_test_helper!
          end
        end
        
        # Load routes from either the helper or the plugin
        def load_routes_with_test_helper!
          if defined?(RAILS_ROOT) && defined?(::ActionController::Routing::Routes) && self == ::ActionController::Routing::Routes
            routes_path = File.join("#{RAILS_ROOT}/config/routes.rb")
            routes_path = File.join("#{HELPER_RAILS_ROOT}/config/routes.rb") if !File.exists?(routes_path)
            
            load File.join(routes_path)
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