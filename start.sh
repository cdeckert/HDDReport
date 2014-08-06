rake db:migrate RAILS_ENV="production" 
RAILS_ENV=production bundle exec rake assets:precompile
service nginx restart