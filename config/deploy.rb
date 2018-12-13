set :application, "workflow-server-rails"

set :repo_url, "https://github.com/sul-dlss-labs/workflow-server-rails.git"

ask :branch, `git rev-parse --abbrev-ref HEAD`.chomp

set :deploy_to, "/opt/app/workflow/workflow-server-rails"

# Default value for :linked_files is []
append :linked_files, "config/database.yml"

# Default value for linked_dirs is []
append :linked_dirs, "log"
