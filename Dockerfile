FROM ruby:3.1.0-slim AS base


WORKDIR /rails
RUN apt-get update -qq && \
    apt-get install --no-install-recommends -y build-essential curl git pkg-config postgresql libpq-dev libyaml-dev && \
    rm -rf /var/lib/apt/lists /var/cache/apt/archives

RUN gem install bundler -v 2.6.3
# throw errors if Gemfile has been modified since Gemfile.lock
# RUN bundle config --global frozen 1

COPY Gemfile Gemfile.lock ./
RUN bundle install

COPY . .

EXPOSE 3000
CMD ["bundle", "exec", "rails", "s", "-b", "0.0.0.0"]