# Load DSL and set up stages
require 'capistrano/setup'

# Include default deployment tasks
require 'capistrano/deploy'

# Include tasks from other gems included in your Gemfile
require 'capistrano/rbenv'
require 'capistrano/bundler'
require 'capistrano/rails/assets'
require 'capistrano/rails/migrations'
require 'capistrano/nginx'
require 'capistrano/passenger'

require 'erb'


namespace :git do
  desc 'Update changed repo url'
  task :update_repo_url do
    on roles :app do
      within repo_path do
        execute :git, 'remote', 'set-url', 'origin', fetch(:repo_url)
      end
    end
  end
end

namespace :cache do
  desc 'Clear tmp cache'
  task :clear do
    on roles :app do
      within "#{current_path}" do
        with rails_env: fetch(:stage) do
          execute :rake, 'tmp:cache:clear'
        end
      end
    end
  end
end

namespace :uploads do
  def send_files(type, server)
    raise "No server given" if !server
    FileUtils.mkdir_p "./uploads/#{type}"
    system "rsync --progress -rue 'ssh -p #{fetch(:port)}' uploads/#{type} #{server.user}@#{server.hostname}:#{shared_path}/uploads/"
  end

  def get_files(type, server)
    raise "No server given" if !server
    FileUtils.mkdir_p "./uploads"
    puts "Importing #{type}. Please wait..."
    system "rsync --progress -rue 'ssh -p #{fetch(:port)}' #{server.user}@#{server.hostname}:#{shared_path}/uploads/#{type} ./uploads/"
  end

  desc 'Import pictures'
  task :import_pictures do
    on roles :app do |host|
      get_files :pictures, host
    end
  end

  desc 'Import attachments'
  task :import_attachments do
    on roles :app do |host|
      get_files :attachments, host
    end
  end

  desc 'Export pictures'
  task :export_pictures do
    on roles :app do |host|
      send_files :pictures, host
    end
  end

  desc 'Export attachments'
  task :export_attachments do
    on roles :app do |host|
      send_files :attachments, host
    end
  end
end

namespace :db do
  desc "Sync local DB with server DB"
  task :server_to_local do
    on roles(:app) do |role|
      within "#{current_path}" do
        with rails_env: fetch(:stage) do
          execute :rake, 'db:data:dump'
        end
        run_locally do
          execute :rsync, "-avzO -e 'ssh -p #{fetch(:port)}' --exclude='.DS_Store' #{role.user}@#{role.hostname}:#{current_path}/db/data.yml db/data.yml"
        end
      end
    end
  end

  desc "Sync server DB with local DB"
  task :local_to_server do
    on roles(:app) do |role|
      run_locally do
        execute :rsync, "-avzO -e 'ssh -p #{fetch(:port)}' --exclude='.DS_Store' db/data.yml #{role.user}@#{role.hostname}:#{current_path}/db/data.yml"
      end
      within "#{current_path}" do
        with rails_env: fetch(:stage) do
          execute :rake, 'db:data:load'
        end
      end
    end
  end
end

namespace :nginx do
  desc 'Export nginx.conf'
  task :export_conf do
    on roles :app do |host|
      File.open('config/nginx.conf', 'w') do |f|
        f.puts ERB.new(File.read('config/nginx.conf.erb')).result
      end
      system "rsync --rsync-path='sudo rsync' --progress 'ssh -p #{fetch(:port)}' 'config/nginx.conf' #{fetch(:sys_admin)}@#{host.hostname}:/opt/nginx/conf/nginx.conf"
      FileUtils.rm_f 'config/nginx.conf'
    end
  end
end

namespace :load do
  task :defaults do
    CONFIG = YAML.load(File.read('config/sunzi/sunzi.yml'))
    CONFIG.symbolize_keys!
    config = CONFIG[:attributes]
    config.symbolize_keys!

    set :application, 'app'
    set :deploy_to, "/home/deploy/app"
    set :rbenv_type, :user
    set :rbenv_ruby, config[:rbenv_ruby]
    set :rbenv_prefix, "RBENV_ROOT=#{fetch(:rbenv_path)} RBENV_VERSION=#{fetch(:rbenv_ruby)} #{fetch(:rbenv_path)}/bin/rbenv exec"
    set :rbenv_map_bins, %w{rake gem bundle ruby rails}
    set :passenger_version, config[:passenger_version]
    set :passenger_restart_with_sudo, false
    set :passenger_restart_command, 'rbenv sudo passenger-config restart-app'
    set :sys_admin, -> { 'admin' }
    set :pty, true
    set :linked_dirs, fetch(:linked_dirs, []).push(*%W[
      log
      tmp/pids
      tmp/cache
      tmp/sockets
      vendor/bundle
      public/system
      public/assets
      public/pictures
      uploads/pictures
      uploads/attachments
    ])
    set :port, -> { 22 }
  end
end
