#!/bin/bash

# Install dependencies
bundle install

# Set up the database
bundle exec rake db:setup

# Start the Rails server
bundle exec rails server -b 0.0.0.0
