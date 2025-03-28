FROM ruby:3.2-slim

RUN apt-get update -qq && \
    apt-get install -y build-essential libsqlite3-dev nodejs git libyaml-dev

WORKDIR /app

COPY app/Gemfile app/Gemfile.lock /app/
RUN bundle install

RUN gem install rails -v 7.1.3

# Accept build arguments and set environment variables
ARG PORT
ENV PORT=${PORT}

EXPOSE ${PORT}

CMD ["rails", "server", "-b", "0.0.0.0"]

