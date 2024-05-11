FROM ruby:3.2.3
RUN apt-get update
RUN apt-get install -y build-essential
WORKDIR /external_authentication
COPY Gemfile /external_authentication/
RUN bundle install
EXPOSE 3013
CMD rm -f /external_authentication/tmp/pids/server.pid && bundle exec rails s -p 3013 -b '0.0.0.0'
