FROM ruby:2.7.0
MAINTAINER monteirobrena@gmail.com

RUN sed -i '/jessie-updates/d' /etc/apt/sources.list

# Dependencies
RUN apt-get update -qq \
    && apt-get install -y \
    build-essential \
    libpq-dev \
    ruby-dev \
    zlib1g-dev \
    curl

# Bundler
RUN gem install bundler --no-doc

# Project setup
RUN mkdir /bookstore_api
WORKDIR /bookstore_api
ADD bookstore_api/Gemfile /bookstore_api/Gemfile
ADD bookstore_api/Gemfile.lock /bookstore_api/Gemfile.lock
RUN bundle install

COPY . /bookstore_api
