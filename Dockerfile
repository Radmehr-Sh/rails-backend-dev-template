## [DN] This multi-stage Dockerfile is used for development and production.
## If you make changes to the development env, we recommend updating the version
## in the `docker-compose.yml` image.

## [DN] These should ideally be the same as what is in `docker-compose.yml`
ARG RUBY_VERSION
ARG DISTRO_NAME

FROM ruby:$RUBY_VERSION-slim-$DISTRO_NAME AS builder

# We have to repeat this because ARGs get reset after each FROM
ARG DISTRO_NAME

LABEL maintainer=''

# This Dockerfile was heavily influenced by this blog post by Evil Martians
# https://evilmartians.com/chronicles/ruby-on-whales-docker-for-ruby-rails-development

# Common dependencies:
# Feel free to add to these but keep them sorted please!
RUN apt-get update -yq \
  && DEBIAN_FRONTEND=noninteractive apt-get install -yq --no-install-recommends \
    build-essential \
    curl \
    git \
    gnupg2 \
    less \
    vim \
  && apt-get clean \
  && rm -rf /var/cache/apt/archives/* \
  && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* \
  && truncate -s 0 /var/log/*log

## [DN] This should ideally be the same as what is in `docker-compose.yml`
# Install PostgreSQL dependencies
ARG PG_MAJOR
RUN curl -sSL https://www.postgresql.org/media/keys/ACCC4CF8.asc | \
    gpg --dearmor -o /usr/share/keyrings/postgres-archive-keyring.gpg \
    && echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/postgres-archive-keyring.gpg] https://apt.postgresql.org/pub/repos/apt/" \
    $DISTRO_NAME-pgdg main $PG_MAJOR | tee /etc/apt/sources.list.d/postgres.list > /dev/null
RUN apt-get update -qq && DEBIAN_FRONTEND=noninteractive apt-get -yq dist-upgrade && \
  DEBIAN_FRONTEND=noninteractive apt-get install -yq --no-install-recommends \
    libpq-dev \
    postgresql-client-$PG_MAJOR \
    && apt-get clean \
    && rm -rf /var/cache/apt/archives/* \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* \
    && truncate -s 0 /var/log/*log


# Install Rails dependencies:
#   activesupport uses tzdata
#   mimemagic uses shared-mime-info
#   nokogiri uses libxml2, zlib1g, liblzma, patch
# Feel free to add to these but keep them sorted please!
RUN apt-get update -yq \
  && DEBIAN_FRONTEND=noninteractive apt-get -yq dist-upgrade \
  && DEBIAN_FRONTEND=noninteractive apt-get install -yq --no-install-recommends \
    liblzma-dev \
    libxml2 \
    libxml2-dev \
    shared-mime-info \
    tzdata \
    zlib1g-dev \
  && apt-get clean \
  && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* \
  && truncate -s 0 /var/log/*log

# Configure our app's home
ENV APP_HOME=${APP_HOME:-/app}

# Configure bundler to retain settings from the project's root and make it
# install in parallel with some retries
ENV BUNDLE_APP_CONFIG="${APP_HOME}/.bundle" \
  BUNDLE_JOBS=4 \
  BUNDLE_RETRY=3

# Set the locale to UTF-8 so that ruby and everything else use that as well
ENV LANG=C.UTF-8

# Run binstubs without needing to prefix `bundle exec`
ENV PATH="${APP_HOME}/bin:${PATH}"

# Upgrade RubyGems and install the latest Bundler version
RUN gem update --system --silent --quiet && \
  gem install bundler

RUN mkdir -p $APP_HOME
WORKDIR $APP_HOME

## [DN] The development stage intentionally stops here without running things
## like `bundle install` or using an ENTRYPOINT. See our blog post for details.
FROM builder AS development
CMD ['/bin/bash']

## [DN] Build and run the production environment
FROM builder AS production

# Explicitly use `production` so that bundler will with the desired environment.
ENV RAILS_ENV=production

ENV BUNDLE_DEPLOYMENT=true \
  BUNDLE_WITHOUT='development:test'

COPY . $APP_HOME
RUN bundle install -j 4

# Document that we're going to expose port 3000
EXPOSE 3000

CMD ['bundle', 'exec', 'puma', '-C', 'config/puma/production.rb']
