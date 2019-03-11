FROM ruby:2.4.1

RUN apt-get update &&\
    apt-get install -y nodejs &&\
    apt-get clean

ENV RAILS_ENV='production'
ENV RACK_ENV='production'
ENV RAILS_ROOT /opt/app/
RUN mkdir -p $RAILS_ROOT
WORKDIR $RAILS_ROOT

COPY . .

RUN bundle install --binstubs --jobs 20 --retry 5 --without development test

EXPOSE 3000
