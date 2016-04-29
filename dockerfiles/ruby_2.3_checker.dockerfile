# docker build -t ruby_2.3_checker -f dockerfiles/ruby_2.3_checker.dockerfile .
FROM ruby:2.3-alpine
RUN gem install rubocop haml_lint
RUN mkdir /source
WORKDIR /source
