FROM ruby:2.6.5

ARG http_proxy

RUN http_proxy=${http_proxy} apt-get -y update && apt-get -y install sqlite3 openssl tzdata build-essential

ENV LANG=C.UTF-8 TZ=Asia/Shanghai RAILS_ENV=production

WORKDIR /app

COPY Gemfile Gemfile
COPY Gemfile.lock Gemfile.lock

RUN gem install bundler && bundle install

COPY app app
COPY bin bin
COPY config config
COPY db db
COPY lib lib
COPY public public
COPY vendor vendor
COPY config.ru config.ru
COPY Rakefile Rakefile

RUN bundle exec rails db:migrate && bundle exec rails db:seed

EXPOSE 3000

CMD bundle exec rails s -b 0.0.0.0


