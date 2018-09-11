FROM starefossen/ruby-node:2-10 AS passenger_ruby

LABEL maintainer="howard@csie.io"


LABEL Name=blogapp Version=0.0.1
EXPOSE 3000

# Default Environment
ENV APACHE_VERSION 2.4.7
ENV PASSENGER_VERSION 5.3.4

# Requirement
RUN apt-get update -qq && apt-get install -y build-essential libpq-dev libpcap-dev libssl-dev


# Passenger gem for production
#RUN gem install passenger -v $PASSENGER_VERSION

# === Rails Application
# FROM AS
FROM passenger_ruby

# locale for unicode
ENV LC_ALL C.UTF-8
# timezone
ENV TZ Asia/Taipei


# throw errors if Gemfile has been modified since Gemfile.lock
RUN bundle config --global frozen 1

WORKDIR /app
COPY . /app

COPY Gemfile Gemfile.lock ./
RUN bundle install

