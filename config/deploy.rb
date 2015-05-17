# config valid only for current version of Capistrano
lock '3.4.0'

set :application, 'pigpen'
set :repo_url, 'git@github.com:rcchen/pigpen.git'

# Default deploy_to directory is /var/www/my_app_name
set :deploy_to, '/var/www/pigpen'

# Default value for :linked_files is []
set :linked_files, %w{puma.rb config/secrets.yml}

# Default value for linked_dirs is []
set :linked_dirs, %w{tmp/pids tmp/sockets log}

# Set user name for deployment
set :user, "roger"

# Set the Rails environment
set :rails_env, "production"

namespace :deploy do

  after :restart, :clear_cache do
    on roles(:web), in: :groups, limit: 3, wait: 10 do
      # Here we can do anything such as:
      # within release_path do
      #   execute :rake, 'cache:clear'
      # end
    end
  end

  after :finishing, 'puma:restart'
  after :finishing, 'nginx:restart'

end

invoke :production
