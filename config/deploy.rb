set :application, "breakglass"
set :repository,  "git://github.com/jbr/breakglass.git"

# If you aren't deploying to /u/apps/#{application} on the target
# servers (which is the default), you can specify the actual location
# via the :deploy_to variable:
# set :deploy_to, "/var/www/#{application}"

# If you aren't using Subversion to manage your source code, specify
# your SCM below:
# set :scm, :subversion

role :app, "breakglass.emicus.com"
role :web, "breakglass.emicus.com"
role :db,  "breakglass.emicus.com", :primary => true
