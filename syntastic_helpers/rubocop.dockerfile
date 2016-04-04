# docker build -t eremite/rubocop -f rubocop .
FROM ruby:2.3.0
RUN gem install rubocop haml_lint
RUN mkdir /source
WORKDIR /source
