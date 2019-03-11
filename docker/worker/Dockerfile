FROM ruby:2.4.1

RUN apt-get update &&\
    apt-get install -y nodejs cron &&\
    apt-get clean

ENV RAILS_ENV='production'
ENV RACK_ENV='production'
ENV RAILS_ROOT /opt/app/
RUN mkdir -p $RAILS_ROOT

RUN cd $RAILS_ROOT
WORKDIR $RAILS_ROOT

COPY Gemfile Gemfile
COPY Gemfile.lock Gemfile.lock
RUN bundle install --binstubs --jobs 20 --retry 5 --without development test

COPY . .

RUN touch ./log/cron.log
CMD bash -c "bundle exec whenever --update-crontab && cron -f"
