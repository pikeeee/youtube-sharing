FROM ruby:3.2.2

RUN apt-get update -qq && apt-get install -y nodejs libpq-dev redis-tools

WORKDIR /app

COPY Gemfile* /app/
RUN gem install bundler && bundle install
COPY . /app

COPY entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]
EXPOSE 3000

CMD ["rails", "server", "-b", "0.0.0.0"]
