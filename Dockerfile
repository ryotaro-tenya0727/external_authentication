FROM ruby:3.2.3
RUN apt-get update
RUN apt-get install -y build-essential
WORKDIR /rails_app
COPY Gemfile /rails_app/
RUN bundle install
EXPOSE 3011
CMD rm -f /authorization_end_point_app/tmp/pids/server.pid && bundle exec rails s -p 3011 -b '0.0.0.0'
