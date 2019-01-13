FROM ruby:2.6
RUN curl -sL https://deb.nodesource.com/setup_10.x | bash -
RUN apt-get update -qq && apt-get install -y nodejs postgresql-client
RUN mkdir /rqdb
WORKDIR /rqdb
COPY Gemfile /rqdb/Gemfile
COPY Gemfile.lock /rqdb/Gemfile.lock
RUN bundle install
COPY . /rqdb

# Add a script to be executed every time the container starts.
COPY docker_entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/docker_entrypoint.sh
ENTRYPOINT ["docker_entrypoint.sh"]
EXPOSE 3000

# Start the main process.
CMD ["rails", "server", "-b", "0.0.0.0"]