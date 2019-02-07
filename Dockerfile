FROM ruby:2.5-alpine

# The postgres-client could be eliminated in production
RUN apk --no-cache add \
  postgresql-dev \
  tzdata

RUN mkdir /app
WORKDIR /app

COPY Gemfile Gemfile.lock ./

RUN apk --no-cache add --virtual build-dependencies \
  build-base \
  && bundle install --without development test\
&& apk del build-dependencies

COPY . .

LABEL maintainer="Justin Coyne <jcoyne@justincoyne.com>"
ENV RAILS_ENV=production

CMD puma -C config/puma.rb
