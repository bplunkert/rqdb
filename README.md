# RQDB: Rash Quote Database
[![Build Status](https://travis-ci.org/bplunkert/rqdb.svg?branch=development)](https://travis-ci.org/bplunkert/rqdb)
[![Heroku Status](https://heroku-badge.herokuapp.com/?app=rqdb)](https://rqdb.herokuapp.com)

## Introduction:
Rash/Rails Quote Database is a simple web application for publishing, sharing, and ranking quotes. It's a ground-up rebuild of the [Rash Quote Management System (RQMS)](http://rqms.sourceforge.net), originally written in PHP by Tom Cuchta. RQDB is written in Ruby on Rails instead of PHP and does not share any common code with the original version.

## Installation
### Depedendencies:
Install [RVM](https://rvm.io) and Ruby 2.6.0:
```curl -sSL https://rvm.io/mpapis.asc | gpg --import -
curl -sSL https://get.rvm.io | bash -s stable --ruby=2.6.0```

Install bundled ruby gems:
```bundle install```

### Main Installation:
```bundle exec rake db:migrate && bundle exec rake db:seed```

### Migration from older PHP versions of Rash:
This task will copy data from legacy PHP versions of Rash into the new Rash/Rails database. Only legacy MySQL databases are supported, and a MySQL client is required. All database settings are automatically detected by reading a configuration file --configfile from the legacy Rash installation.

This example installs into the production database, but set RAILS_ENV and other options as needed:
```bundle install --with legacy_migration
RAILS_ENV=production bundle exec rake legacy:migrate_database --configfile CONFIGFILE```

For more options, you can pass the --help flag:
```RAILS_ENV=production bundle exec rake legacy:migrate_database --help```

When you're sure you are ready to run the migration, pass the --write flag:
```RAILS_ENV=production bundle exec rake legacy:migrate_database --configfile CONFIGFILE```

### Start the service:
```bundle exec rails server```

### Start the chatbots (if applicable):
```bundle exec rake chatbot:all```

### Login:
* Browse to http://localhost:3000
* Default username: admin@admin.admin
* Default password: password

## Docker
### Build
Build the web and database images:
```docker-compose build web```

Build the chatbot image:
```docker-compose build chatbot```

### Run
Run the web and database containers:
```docker-compose run web```

Run the chatbot container:
```docker-compose run chatbot```
