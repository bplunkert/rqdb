# RQDB: Rash Quote Database
[![Build Status](https://travis-ci.org/bplunkert/rqdb.svg?branch=development)](https://travis-ci.org/bplunkert/rqdb)
[![Heroku Status](https://heroku-badge.herokuapp.com/?app=rqdb)](https://rqdb.herokuapp.com)

## Introduction:
Rash/Rails Quote Database is a simple web application for publishing, sharing, and ranking quotes. It's a ground-up rebuild of the [Rash Quote Management System (RQMS)](http://rqms.sourceforge.net), originally written in PHP by Tom Cuchta. RQDB is written in Ruby on Rails instead of PHP and does not share any common code with the original version.

## Installation
### Depedendencies:
Install [RVM](https://rvm.io) and Ruby 2.5.1:
* ```curl -sSL https://rvm.io/mpapis.asc | gpg --import -```
* ```curl -sSL https://get.rvm.io | bash -s stable --ruby=2.5.1```

Install bundled ruby gems:
* ```bundle install```
* Note: if bundle install fails due to postgres errors, you can safely skip this for development and testing by running: ```bundle install --without production```

### Main Installation:
* ```bundle exec rake db:migrate```
* ```bundle exec rake db:seed```

### Migration from older PHP versions of Rash:
This step will connect to a legacy Rash MySQL database and copy all existing data into the  Currently only Rash 2.0 Beta version is supported. A MySQL client will be required. The example installs into the production database but set RAILS_ENV and other options as needed.
* ```bundle install --with legacy_migration```
* ```RAILS_ENV=production bundle exec rake legacy:migrate_database --host SERVER --username USERNAME --database DATABASE --password PASSWORD```

For more options, you can pass the --help flag:
```bundle exec rake legacy:migrate_database --help```

### Start the service:
* ```bundle exec rails server```

### Login:
* Browse to http://localhost:3000
* Default username: admin@admin.admin
* Default password: password