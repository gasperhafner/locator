server "207.154.238.233", user: "rails", roles: %w{app db web}

set :deploy_to, "/home/rails/staging-locator"
set :branch, "develop"
set :rails_env, "staging"

namespace :deploy do
  desc 'Restart application'
  task :restart do
    on roles(:app), in: :sequence, wait: 5 do
      # Your restart mechanism here, for example:
      execute "sudo systemctl restart rails.service"
      #execute "sudo /usr/bin/monit restart sidekiq_staging_laundryheap_com"
    end
  end
  after :finished, :restart
end
