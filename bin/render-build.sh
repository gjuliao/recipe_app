#!/bin/bash

# Precompile assets
bundle exec rake assets:precompile RAILS_ENV=production

# Migrate database
bundle exec rake db:migrate RAILS_ENV=production

# Restart application server
touch tmp/restart.txt
