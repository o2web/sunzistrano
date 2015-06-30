module Sunzistrano
  module Generators
    class InstallGenerator < Rails::Generators::Base
      desc "Create local nginx and unicorn configuration files for customization"
      source_root File.expand_path('../templates', __FILE__)

      def copy_template
        directory "deploy",         "config/deploy"
        directory "environments",   "config/environments"
        directory "sunzi",          "config/sunzi"
        copy_file "Capfile",        "../config/Capfile"
        copy_file "database.yml",   "config/database.yml"
        copy_file "deploy.rb",      "config/deploy.rb"
        copy_file "nginx.conf.erb", "config/nginx.conf.erb"
      end
    end
  end
end
