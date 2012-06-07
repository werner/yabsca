require 'coffee-script'
require 'find'

namespace :sencha do

  desc 'Compiles Ext JS application CoffeeScript and performs JSB3 build and create.'
  task :compile do

    tmp_js = "#{File.dirname(__FILE__)}/../../tmp/sencha"

    src_app = "#{File.dirname(__FILE__)}/../../app/assets/javascripts/app"
    tmp_app = File.expand_path("#{tmp_js}/assets/app")

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
    
    # Copies template app.html needed for Sencha SDK Tools.
    FileUtils.cp "#{File.dirname(__FILE__)}/../assets/app.html", "#{tmp_js}/app.html"
    
    ## Create Ext JS library symlink.
    ext = "#{File.dirname(__FILE__)}/../../public/ext"
    ext_symlink = "#{tmp_js}/ext"

    File.symlink(ext, ext_symlink)

    # Create JSB3 file for Docs app
    system("sencha", "create", "jsb", "-a", "#{tmp_js}/app.html", "-p", "#{tmp_js}/app.jsb3")
    
    # Update JSB3 meta-data.
    jsb3 = File.read("#{tmp_js}/app.jsb3")
    
    jsb3 = jsb3.gsub("Project Name", "My Project")
    jsb3 = jsb3.gsub("Company Name", "My Company")
    
    File.open("#{tmp_js}/app.jsb3", "w") do |f|
      f.write jsb3
    end
    
    system("sencha", "build", "-p", "#{tmp_js}/app.jsb3", "-d", tmp_js)
  end
end
