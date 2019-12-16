FROM ruby:2.6.5
MAINTAINER aleksandr.s.babak@gmail.com

RUN apt-get update && apt-get install -y \
  build-essential
RUN mkdir -p /app
WORKDIR /app
COPY config/database.yml.sample ./config/database.yml
COPY Gemfile Gemfile.lock ./
RUN gem install bundler && bundle install --jobs 20 --retry 5
COPY . ./

EXPOSE 3000

