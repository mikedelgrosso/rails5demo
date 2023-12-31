FROM --platform=linux/amd64 ruby:2.7.2
RUN apt-get update -qq && apt-get install -y postgresql-client
WORKDIR /myapp
ENV RAILS_ENV=production

COPY Gemfile /myapp/Gemfile
COPY Gemfile.lock /myapp/Gemfile.lock
RUN apt install -y Node.js 
RUN apt install -y npm
RUN bundle config set force_ruby_platform true
RUN bundle install
COPY . /myapp

# Add a script to be executed every time the container starts.
COPY entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]
EXPOSE 3000

# Start the main process.
CMD ["rails", "server", "-b", "0.0.0.0"]
