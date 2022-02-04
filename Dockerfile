FROM ruby:2.6

RUN \
  apt-get update && apt-get install -y \
  build-essential \
  ruby-dev \
  cron

RUN mkdir -p /app
WORKDIR /app

COPY entrypoint.sh daily.crontab Gemfile Gemfile.lock ./
RUN gem install bundler && bundle install --jobs 20 --retry 5

COPY . ./

ENTRYPOINT bash /app/entrypoint.sh
