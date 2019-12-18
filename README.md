# README

* Run app

`cd your_front_vue_app_folder`
`docker build . -t emp-rss-vue`
`cd your_rails_app_folder`
`docker build . -t emp-rss-rails`

`SECRET_KEY_BASE=9cf67a7bf78ff4633896482ad1029fef IMAGE_PROD_FRONT=emp-rss-vue:latest IMAGE_PROD_BACK=emp-rss-rails:latest PUMA_MIN_THREADS=3 PUMA_MAX_THREADS=5 CORS_LIST=http://localhost:8080 LOGS_FOLDER=./log DB_PASS=0ce935f3e5176c1b DB_NAME=emp_rss_production DB_USER=emp_rails RAILS_ENV=production docker-compose up`

then in another terminal

`SECRET_KEY_BASE=9cf67a7bf78ff4633896482ad1029fef IMAGE_PROD=emp-rss-rails:latest PUMA_MIN_THREADS=3 PUMA_MAX_THREADS=5 CORS_LIST=http://localhost:8080 LOGS_FOLDER=./log DB_PASS=0ce935f3e5176c1b DB_NAME=emp_rss_production DB_USER=emp_rails RAILS_ENV=production docker-compose run back bundle exec rake db:create`

`SECRET_KEY_BASE=9cf67a7bf78ff4633896482ad1029fef IMAGE_PROD=emp-rss-rails:latest PUMA_MIN_THREADS=3 PUMA_MAX_THREADS=5 CORS_LIST=http://localhost:8080 LOGS_FOLDER=./log DB_PASS=0ce935f3e5176c1b DB_NAME=emp_rss_production DB_USER=emp_rails RAILS_ENV=production docker-compose run back bundle exec rake db:migrate`
