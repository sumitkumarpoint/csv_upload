# CSV Upload

CSV Upload is basically for creating people table record using csv file. If any record failed to save in database then you can change value from listing and hit save button to create it.

# Technologies
- Rails
- PostGres

Project revisions are managed in **csv_upload** repository on private server with [GIT]( https://github.com/sumitkumarpoint/csv_upload.git ).

### Installation


CSV Upload requires [Ruby](https://www.ruby-lang.org/en/documentation/installation/) v2.6.3  and Rails 5.2.6 to run.


Clone the git repository and install packages.
```sh
$ git clone https://github.com/sumitkumarpoint/csv_upload.git
$ cd csv_upload
$ bundle install
```
Setup database.
```sh
$ rake db:create
$ rake db:migrate
$ rake db:seed #This id optional as there no code in seed file.
$ rails s
```
Run RSpec.
```sh
$ export RAILS_ENV=test
$ rspec spec/
```
