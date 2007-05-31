# Automatically load the plugin being tested as if it were being loaded in an
# actual application
init_path = "#{RAILS_ROOT}/../../init.rb"
silence_warnings { eval(IO.read(init_path), binding, init_path) } if File.exists?(init_path)