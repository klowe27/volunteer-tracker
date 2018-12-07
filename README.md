# Volunteer Tracker

#### Ruby Volunteer Tracker, 12.7.18

#### By Kristin Brewer-Lowe

## Description

This basic application is a volunteer tracker to enable a non-project to track their projects and volunteers.

## Setup/Installation Requirements

* View directly at:
* Or, in the command line, clone this repository with $ git clone https://github.com/klowe27/volunteer-tracker
* Navigate into the directory in the command line and install dependent gems by using command $ bundle install
* To create the necessary database, use the following commands in the command line while in the root directory (must have psql installed):
  * createdb volunteer_tracker
  * psql volunteer_tracker < database_backup.sql
  * createdb -T volunteer_tracker volunteer_tracker_test
* To launch the application, use command $ ruby app.rb
* In any browser (preferably Chrome), navigate to http://localhost:4567/

## Known Bugs

* There are no known bugs at this time.

## Support and contact details

If you have any questions or issues, please contact kristin.lowe1@gmail.com. Or, feel free to contribute to the code.

## Technologies Used

Ruby, Sinatra, psql, Capybara, HTML, CSS and Git.

### License

This software is licensed under the MIT license.

Copyright (c) 2018 **Kristin Brewer-Lowe**
