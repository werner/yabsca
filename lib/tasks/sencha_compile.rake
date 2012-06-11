require 'coffee-script'
require 'find'

namespace :sencha do

  desc 'Compiles Ext JS application CoffeeScript and performs JSB3 build and create.'
  task :create do

    Rake::Task['assets:clean'].invoke

    tmp_js = "#{File.dirname(__FILE__)}/../../tmp/sencha"

    src_app = "#{File.dirname(__FILE__)}/../../app/assets/javascripts"

    tmp_app = File.expand_path("#{tmp_js}/assets")

    FileUtils.rm_rf tmp_js

    Find.find(src_app) do |f|
      if File.extname(f) == '.coffee'
        js_file = "#{tmp_app}#{f.gsub(src_app, "")}".chomp('.coffee')
        js_dir = File.dirname(js_file)

        js = CoffeeScript.compile File.read(f)

        FileUtils.mkdir_p js_dir if !File.exists?(js_dir)
        open js_file, 'w' do |f|
          f.puts js
        end
      end
    end
    
    # Moves app.js to top-level.
    FileUtils.mv "#{tmp_app}/app.js", "#{tmp_js}/app.js"
    
    ## Create Ext JS library symlink.
    ext = "#{File.dirname(__FILE__)}/../../vendor/assets/javascripts/ext/"
    ext_symlink = "#{tmp_app}/ext"

    File.symlink(ext, ext_symlink)

    # Create JSB3 file for Docs app
    # requires the server up and running
    system("/opt/SenchaSDKTools-2.0.0-beta3/sencha", "create", "jsb", "-a", 
            "http://localhost:3000", "-p", "#{tmp_js}/app.jsb3")
  end

  task :compile do
    tmp_js = "#{File.dirname(__FILE__)}/../../tmp/sencha"

    # Update JSB3 meta-data.
    jsb3 = File.read("#{tmp_js}/app.jsb3")
    
    jsb3 = jsb3.gsub("Project Name", "YABSCA")
    
    File.open("#{tmp_js}/app.jsb3", "w") do |f|
      f.write jsb3
    end
    
    system("/opt/SenchaSDKTools-2.0.0-beta3/sencha", "build", "-p", "#{tmp_js}/app.jsb3", "-d", tmp_js)

    FileUtils.mv "#{tmp_js}/all-classes.js", "#{File.dirname(__FILE__)}/../../app/assets/javascripts/all-classes.js"
    FileUtils.mv "#{tmp_js}/app-all.js", "#{File.dirname(__FILE__)}/../../app/assets/javascripts/app-all.js"

    Rake::Task['assets:precompile'].invoke
  end
end
