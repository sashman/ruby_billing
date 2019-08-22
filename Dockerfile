FROM ruby:2.5

RUN gem install bundler \
    && bundle config --global frozen 1

WORKDIR /usr/src/app

COPY ruby_billing.gemspec Gemfile Gemfile.lock ./
COPY lib/ruby_billing/version.rb lib/ruby_billing/version.rb
RUN bundle install

COPY . .

CMD ["rspec"]