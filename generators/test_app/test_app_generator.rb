class TestingForPluginGenerator < Rails::Generator::NamedBase
puts File.expand_path('.')

  def manifest
    record do |m|
      testing_app_name = name + '_test_app'
      
      # paths are relative to our template dir
      output_relpath = "vendor/plugins/#{name}/test/railsroot"
      railties_relpath = '../../../../../rails/railties'  
      # this is fragile, ugly and depends on a frozen rails
      # consider something like Rails::Generator::Base.use_application_sources! if possible...
require 'rails_generator/scripts/generate'
Rails::Generator::Base.use_application_sources!
Rails::Generator::Scripts::Generate.new.run(ARGV, :generator => 'app')
      m.class_collisions testing_app_name # necessary? 
      
      # create the 18 dirs and files listed at http://www.pluginaweek.org/2006/11/24
      %W[
        #{}
        app/controllers
        config/environments
        db/migrate
        lib
        log
        script/console
        vendor/plugins
      ].each { |dir|  m.directory "#{output_relpath}/#{dir}" }
      
      m.template "#{railties_relpath}/helpers/application.rb", "#{output_relpath}/app/controllers/application.rb", :assigns => {:app_name => testing_app_name }
      
      m.file "database.yml", "#{output_relpath}/database.yml"
      %w[ mysql postgresql sqlite sqlite3 ].each do |name|
        m.file "empty.rb", "#{output_relpath}/config/environments/#{name}.rb"
      end
      m.file "environment.rb", "#{output_relpath}/environment.rb"
      m.file "#{railties_relpath}/environments/boot.rb", "#{output_relpath}/config/boot.rb"
      m.template "#{railties_relpath}/configs/routes.rb", "#{output_relpath}/config/routes.rb"
    end
  end

  protected
    def banner
      "Usage: #{$0} testing_for_plugin your_plugin"
    end
end