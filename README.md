# README

[![Build Status](http://travis-ci.org/Limnogirl90/gsl-usgs.svg?branch=master)](https://travis-ci.org/Limnogirl90/gsl-usgs) [![Coverage Status](http://coveralls.io/repos/github/Limnogirl90/gsl-usgs/badge.svg?branch=master)](https://coveralls.io/github/Limnogirl90/gsl-usgs?branch=master)

* Ruby version: 2.5.0

* System dependencies: PostgreSQL 9.6 is expected in prod (Heroku)

* Configuration: bundle install

* Database creation: rake db:create

    GSL_USGS_DATABASE_PASSWORD='GSL-USGS_DATABASE_PASSWORD' RAILS_ENV=production rake db:create


* Database initialization: rake db:migrate: rake db:seed

* How to run the test suite: rake

# Still to be documented:

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* ...
