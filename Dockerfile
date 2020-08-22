#Node.js & Yarn
FROM node:13.5-alpine as node

RUN apk add --no-cache bash curl && \
    curl -o- -L https://yarnpkg.com/install.sh | bash -s -- --version 1.21.1


#Ruby & Bundler & postgresql-client
FROM ruby:2.6.5-alpine

ENV RUNTIME_PACKAGES="linux-headers libxml2-dev make gcc libc-dev nodejs tzdata postgresql-dev postgresql yarn vim" \
    CHROME_PACKAGES="chromium-chromedriver zlib-dev chromium xvfb wait4ports xorg-server dbus ttf-freefont mesa-dri-swrast udev" \
    BUILD_PACKAGES="build-base curl-dev" \
    ROOT="/myapp" \
    LANG=C.UTF-8 \
    TZ=Asia/Tokyo

COPY --from=node /usr/local/bin/node /usr/local/bin/node
COPY --from=node /opt/yarn-* /opt/yarn
RUN ln -fs /opt/yarn/bin/yarn /usr/local/bin/yarn
RUN apk add --no-cache git build-base libxml2-dev libxslt-dev postgresql-dev postgresql-client tzdata bash less && \
    cp /usr/share/zoneinfo/Asia/Tokyo /etc/localtime

RUN apk update && \
    apk upgrade && \
    apk add --no-cache ${RUNTIME_PACKAGES} && \
    apk add --no-cache ${CHROME_PACKAGES} && \
    apk add --virtual build-packages --no-cache ${BUILD_PACKAGES}

# chromeの追加
RUN  apk add --update chromium chromium-chromedriver

RUN apk add --no-cache alpine-sdk \
    mysql-client \
    mysql-dev

ENV APP_ROOT /sbkn_blog
RUN mkdir $APP_ROOT
WORKDIR $APP_ROOT

RUN gem update --system && \
    gem install --no-document bundler:2.1.4

ADD ./Gemfile $APP_ROOT/Gemfile
ADD ./Gemfile.lock $APP_ROOT/Gemfile.lock

RUN bundle install

ADD . $APP_ROOT

RUN rails assets:precompile RAILS_ENV=production
RUN rails webpacker:compile RAILS_ENV=production