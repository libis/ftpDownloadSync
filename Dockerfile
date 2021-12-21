FROM ruby:2.4.3
# A minimal Dockerfile based on Ruby (2.3, 2.4, 2.5 or 2.6) Dockerfile (regular, slim or alpine) with Node.js 10 LTS (Dubnium) installed.
#FROM timbru31/ruby-node  

# Install gems
ENV APP_HOME /app
ENV HOME /root

RUN cp /usr/share/zoneinfo/CET /etc/localtime 
RUN apt-get update
RUN apt-get install sgrep

RUN mkdir $APP_HOME
WORKDIR $APP_HOME
COPY Gemfile ./
RUN gem install bundler
RUN bundle install
