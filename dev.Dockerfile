FROM ruby:3.3.2
WORKDIR /app
RUN apt-get update -qq && apt-get install -y postgresql-client
COPY Gemfile Gemfile.lock ./
RUN bundle install
COPY . .
