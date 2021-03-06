# config valid only for current version of Capistrano
lock '3.4.0'

set :repo_url, 'git@todo.todo:todo/todo.git'

# user with root access for nginx:export_conf
# set :sys_admin, 'admin'

# Default value for :linked_files is []
# set :linked_files, fetch(:linked_files, []).push(*%W[
#   config/database.yml
#   config/secrets.yml
# ])

# Default value for linked_dirs is []
# set :linked_dirs, fetch(:linked_dirs, []).push(*%W[
# ])

# Default value for keep_releases is 5
# set :keep_releases, 5

namespace :deploy do
  after :restart, :clear_cache do
    on roles(:web), in: :groups, limit: 3, wait: 10 do
      # Here we can do anything such as:
      # within release_path do
      #   execute :rake, 'cache:clear'
      # end
    end
  end
end
