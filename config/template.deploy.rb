set :application, "hyggelig.org"
set :repository,  "git://github.com/awendt/hyggelig.git"
set :branch, "master"
set :deploy_via, :remote_cache
set :rails_gem_version, '2.3.2'
ssh_options[:compression] = false

set :scm, "git"
set :use_sudo, false

# What you need to fill in
set :user, "SSH login for the deployment user"
set :deploy_to, "/path/to/deploy/target"
set :port_number, "ask your hosting provider"
role :app, "your app server"
role :web, "your web server"
role :db,  "your DB server", :primary => true

namespace :deploy do

  task :start, :roles => :app do
    run "cd #{deploy_to}/current; mongrel_rails start -e production -p #{port_number} -d"
  end
  task :stop, :roles => :app do
    run "cd #{deploy_to}/current; mongrel_rails stop"
  end
  task :restart, :roles => :app do
    run "cd #{deploy_to}/current; mongrel_rails stop; mongrel_rails start -e production -p #{port_number} -d"
  end

  desc "Symlink the database config file from shared directory to current release dir"
  task :symlink_database_yml do
    run "ln -nsf #{shared_path}/config/database.yml #{release_path}/config/database.yml"
  end

  desc "Symlink session_key_secret config file from shared directory to current release dir"
  task :symlink_session_key_secret do
    run "ln -nsf #{shared_path}/config/session_key_secret #{release_path}/config/session_key_secret"
  end

  desc "Symlink frozen rails to current release dir"
  task :symlink_frozen_rails do
    run "ln -nsf #{shared_path}/rails-#{rails_gem_version} #{release_path}/vendor/rails"
  end

  after 'deploy:update_code', 'deploy:symlink_database_yml'
  after 'deploy:update_code', 'deploy:symlink_session_key_secret'
  after 'deploy:update_code', 'deploy:symlink_frozen_rails'
end
