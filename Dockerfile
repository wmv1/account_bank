FROM ruby:2.5.0

ENV APP_PATH /var/app
ENV BUNDLE_VERSION 1.17.3
ENV BUNDLE_PATH /usr/local/bundle/gems

ENV NODE_VERSION 12

RUN curl -sL https://deb.nodesource.com/setup_$NODE_VERSION.x | bash -

RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add -
RUN echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list

RUN apt-get update -qq
RUN apt-get install -y --no-install-recommends nodejs \
      locales yarn

RUN gem install bundler --version "$BUNDLE_VERSION"


WORKDIR $APP_PATH


COPY Gemfil* ./
COPY vendor ./vendor/

RUN bundle "_""$BUNDLE_VERSION""_" install
