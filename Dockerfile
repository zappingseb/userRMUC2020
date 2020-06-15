FROM rocker/tidyverse
MAINTAINER Sebastian Engel-Wolf (sebastian@mail-wolf.de)

## Install packages from CRAN
RUN install2.r --error \ 
    -r 'http://cran.rstudio.com' \
    ggplot2 \
    DT \
    rlang \
    stringr \
    shiny \
    shinyjs \
    shinytest \
    webdriver \
    webshot \
    ## clean up
    && rm -rf /tmp/downloaded_packages/ /tmp/*.rds

ARG PHANTOM_JS_VERSION
ENV PHANTOM_JS_VERSION ${PHANTOM_JS_VERSION:-2.1.1-linux-x86_64}

# Install runtime dependencies
RUN apt-get update \
 && apt-get install -y --no-install-recommends \
        ca-certificates \
        bzip2 \
        libfontconfig \
 && apt-get clean \
 && rm -rf /var/lib/apt/lists/*

# Install official PhantomJS release
# Install dumb-init (to handle PID 1 correctly).
# https://github.com/Yelp/dumb-init
# Runs as non-root user.
# Cleans up.
RUN set -x  \
 && apt-get update \
 && apt-get install -y --no-install-recommends \
        curl \
 && mkdir /tmp/phantomjs \
 && curl -L https://bitbucket.org/ariya/phantomjs/downloads/phantomjs-${PHANTOM_JS_VERSION}.tar.bz2 \
        | tar -xj --strip-components=1 -C /tmp/phantomjs \
 && mv /tmp/phantomjs/bin/phantomjs /usr/local/bin \
 && curl -Lo /tmp/dumb-init.deb https://github.com/Yelp/dumb-init/releases/download/v1.1.3/dumb-init_1.1.3_amd64.deb \
 && dpkg -i /tmp/dumb-init.deb \
 && apt-get purge --auto-remove -y \
        curl \
 && apt-get clean \
 && rm -rf /tmp/* /var/lib/apt/lists/* \
 && useradd --system --uid 52379 -m --shell /usr/sbin/nologin phantomjs \
 && export OPENSSL_CONF=/etc/ssl/ \
 && su phantomjs -s /bin/sh -c "phantomjs --version"


COPY . $HOME/src/

WORKDIR $HOME/src/

RUN R CMD build .

ENV NOT_CRAN true
ENV OPENSSL_CONF /etc/ssl/

RUN R CMD check --no-manual *tar.gz

RUN Rscript "check_checks.R"