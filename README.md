# RQDB: Rash Quote Database
[![Build Status](https://travis-ci.org/bplunkert/rqdb.svg?branch=development)](https://travis-ci.org/bplunkert/rqdb)

Rash/Rails Quote Database is a simple web application for publishing, sharing, and ranking quotes. It's a ground-up rebuild of the [Rash Quote Management System (RQMS)](http://rqms.sourceforge.net), originally written in PHP by Tom Cuchta. RQDB is written in Ruby on Rails instead of PHP and does not share any common code with the original version.

Depedendencies:
Install [RVM](https://rvm.io) and Ruby 2.5.1:
* * ```curl -sSL https://rvm.io/mpapis.asc | gpg --import -```
* * ```curl -sSL https://get.rvm.io | bash -s stable --ruby=2.5.1```

Install gem dependencies:
* ```bundle install```

Installation:
* ```bundle exec rake db:migrate```
* ```bundle exec rake db:seed```

Start the service:
* ```bundle exec rails server```

Login:
* Browse to http://localhost:3000
* Default username: admin@admin.admin
* Default password: password