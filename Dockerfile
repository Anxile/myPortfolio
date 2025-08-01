# syntax = docker/dockerfile:1

ARG RUBY_VERSION=3.3.7
FROM registry.docker.com/library/ruby:$RUBY_VERSION-slim AS base

WORKDIR /rails

ENV RAILS_ENV="production" \
    BUNDLE_DEPLOYMENT="1" \
    BUNDLE_PATH="/usr/local/bundle" \
    BUNDLE_WITHOUT="development"

# --------------------- Build Stage ---------------------
FROM base AS build

RUN apt-get update -qq && \
    apt-get install --no-install-recommends -y \
    build-essential \
    git \
    libvips \
    pkg-config \
    libpq-dev \
    libyaml-dev \
    curl \
    postgresql-client \
    nodejs \
    yarn

COPY Gemfile Gemfile.lock ./
RUN bundle install && \
    rm -rf ~/.bundle/ "${BUNDLE_PATH}"/ruby/*/cache "${BUNDLE_PATH}"/ruby/*/bundler/gems/*/.git && \
    bundle exec bootsnap precompile --gemfile

COPY .env.production /rails/.env.production

COPY . .

RUN bundle exec bootsnap precompile app/ lib/

RUN chmod +x bin/* && \
    sed -i "s/\r$//g" bin/* && \
    sed -i 's/ruby\.exe$/ruby/' bin/*

RUN SECRET_KEY_BASE=dummy ./bin/rails assets:precompile

# --------------------- Final Stage ---------------------
FROM base

RUN apt-get update -qq && \
    apt-get install --no-install-recommends -y \
    curl \
    libsqlite3-0 \
    libvips \
    libpq5 && \
    rm -rf /var/lib/apt/lists /var/cache/apt/archives

COPY --from=build /usr/local/bundle /usr/local/bundle
COPY --from=build /rails /rails

RUN useradd rails --create-home --shell /bin/bash && \
    chown -R rails:rails db log storage tmp

USER rails:rails
WORKDIR /rails

ENTRYPOINT ["./bin/rails", "server", "-b", "0.0.0.0"]

EXPOSE 3000
