set :application, "breakglass"
set :repository,  "git://github.com/jbr/breakglass.git"

# If you aren't deploying to /u/apps/#{application} on the target
# servers (which is the default), you can specify the actual location
# via the :deploy_to variable:
set :deploy_to, "/site/#{application}"

# If you aren't using Subversion to manage your source code, specify
# your SCM below:
set :scm, :git

role :app, "breakglass.emicus.com"
role :web, "breakglass.emicus.com"
role :db,  "breakglass.emicus.com", :primary => true

default_run_options[:pty] = true

after 'deploy:symlink', 'deploy:copy_config_files'

namespace :deploy do
  task :copy_config_files do
    run "cp #{shared_path}/config/* #{current_path}/config"
  end
end

