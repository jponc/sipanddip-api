FROM ruby:2.4.1

RUN apt-get update &&\
    apt-get install -y nodejs cron &&\
    apt-get clean

ENV RAILS_ENV='production'
ENV RACK_ENV='production'
ENV RAILS_ROOT /opt/app/
RUN mkdir -p $RAILS_ROOT
WORKDIR $RAILS_ROOT

COPY Gemfile Gemfile
COPY Gemfile.lock Gemfile.lock

COPY . .

RUN touch ./log/cron.log


RUN bundle install --jobs 20 --retry 5 --without development test
RUN bundle exec whenever --update-crontab

EXPOSE 3000
