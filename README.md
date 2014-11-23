## README

Foodie allows groups to co-plan dinners, uses google oauth integration.

Things you may want to cover:

### Ruby version
  - 2.1.2

### System dependencies
  - v8
  - postgres

### Configuration
  ```
    $  cp config/database.example.yml config/database.yml
    $  cp config/application.example.yml config/application.yml
  ```
  
  Get Configuration values from heroku, a friend, or supply your own.
  ```
    $ heroku config --app foodie-planner
  ```

#### Required configuration:
  - `google_client_key`
  - `google_client_secret`
  - `SENDGRID_USERNAME`
  - `SENDGRID_PASSWORD`
  - `default_email`

### Database creation
  ```
    bundle exec rake db:create
  ```

### Database initialization
  ```
    bundle exec rake db:schema:load
  ```

### How to run the test suite

  NOTE: Specs are WIP for new feature, primarily

  ```
    bundle exec rake spec
  ```

### Services (job queues, cache servers, search engines, etc.)
  N/A

### Deployment instructions
  ```
    heroku git:remote -a foodie-planner # setup git remote
    git push heroku master
  ```
