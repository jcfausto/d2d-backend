FROM ruby:2.6.3

# Installing application dependencies
RUN apt-get update -qq && apt-get install -y build-essential

# for a JS runtime
RUN apt-get install -y nodejs

RUN gem install bundler --no-verbose --no-document

ENV RACK_ENV="development"
ENV APP_HOME /usr/src/app

RUN mkdir $APP_HOME
WORKDIR $APP_HOME
ADD . $APP_HOME
RUN bundle install --jobs 20 --retry 5

EXPOSE 3000
CMD ["rake", "start"]
