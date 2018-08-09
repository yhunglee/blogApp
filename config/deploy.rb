# config valid for current version and patch releases of Capistrano
lock "~> 3.10.2"

set :application, "blogApp"
set :repo_url, "git@github.com:yhunglee/blogApp.git"

# Default branch is :master
# ask :branch, `git rev-parse --abbrev-ref HEAD`.chomp

# Default deploy_to directory is /var/www/my_app_name
#set :deploy_to, "/var/www/blogApp"

# Default value for :format is :airbrussh.
# set :format, :airbrussh

# You can configure the Airbrussh format using :format_options.
# These are the defaults.
# set :format_options, command_output: true, log_file: "log/capistrano.log", color: :auto, truncate: :auto

# Default value for :pty is false
# set :pty, true

# Default value for :linked_files is []
# append :linked_files, "config/database.yml"
append :linked_files, "config/database.yml", "config/credentials.yml.enc", "config/master.key", ".env"

# Default value for linked_dirs is []
# append :linked_dirs, "log", "tmp/pids", "tmp/cache", "tmp/sockets", "public/system"
append :linked_dirs, "log", "tmp/pids", "tmp/cache", "tmp/sockets", "public/system", 'public/uploads'


# Set rvm type
#set :rvm_type, :user
set :rvm_custom_path, '/usr/local/rvm'

# Remote server using rvm
set :rvm_ruby_version, '2.4.2@blogapp-rails-5.2.0-ruby-2.4.2'

# Default value for default_env is {}
# set :default_env, { path: "/opt/ruby/bin:$PATH" }
# set :default_env, { path: "/usr/share/rvm/rubies/ruby-2.4.2/bin/ruby:$PATH" }

# Default value for local_user is ENV['USER']
# set :local_user, -> { `git config user.name`.chomp }

# Default value for keep_releases is 5
# set :keep_releases, 5

# Uncomment the following to require manually verifying the host key before first deploy.
# set :ssh_options, verify_host_key: :secure


namespace :deploy do
    # If you want to restart using `passenger-config restart-app`, add this to your config/deploy.rb,
    # set :passenger_restart_with_touch, false # Note that `nil` is NOT the same as `false` here
    set :passenger_restart_with_touch, false

    # Fix restart passenger app error when cap production deploy
    set :passenger_restart_command, '-i passenger-config restart-app'

    # If you are installing passenger during your deployment AND you want to restart using `passenger-config restart-app`,
    # you need to set `:passenger_in_gemfile` to `true` in your `config/deploy.rb`.
    set :passenger_in_gemfile, true
end