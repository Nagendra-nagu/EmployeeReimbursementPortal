# config/deploy.rb

# Define the repository
set :repo_url, 'git@github.com:Nagendra-nagu/EmployeeReimbursementPortal.git'

# Define the directory to deploy to
set :deploy_to, '/home/ubuntu/ReimbursementPortal'

# Set the branch to deploy
set :branch, 'master'

# Linked files and directories
append :linked_files, 'config/database.yml', 'config/master.key'
append :linked_dirs, 'log', 'tmp/pids', 'tmp/cache', 'tmp/sockets', 'vendor/bundle', 'public/system'

# Set RVM settings
set :rvm_type, :user
set :rvm_ruby_version, '3.1.0'

# Puma configuration
set :puma_threads, [4, 16]
set :puma_workers, 0
set :puma_bind, "unix://#{shared_path}/tmp/sockets/puma.sock"
set :puma_state, "#{shared_path}/tmp/pids/puma.state"
set :puma_pid, "#{shared_path}/tmp/pids/puma.pid"
set :puma_access_log, "#{shared_path}/log/puma.error.log"
set :puma_error_log, "#{shared_path}/log/puma.access.log"
set :puma_preload_app, true
set :puma_worker_timeout, nil
set :puma_init_active_record, false
set :puma_env, fetch(:rack_env, fetch(:rails_env, 'production'))

# Deployment settings
set :pty, true
set :use_sudo, false
set :stage, :production
set :deploy_via, :remote_cache
set :keep_releases, 5

namespace :deploy do
  after :finishing, 'deploy:cleanup'
  after 'deploy:publishing', 'deploy:restart'
  after :restart, :clear_cache do
    on roles(:web), in: :groups, limit: 3, wait: 10 do
    end
  end
end

# Require Capistrano Puma in deploy.rb
require 'capistrano/puma'
require 'capistrano/puma/workers'
require 'capistrano/puma/jungle'
