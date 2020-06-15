FROM rocker/tidyverse
MAINTAINER Sebastian Engel-Wolf (sebastian@mail-wolf.de)

RUN apt-get update \
    && apt-get install -y --no-install-recommends \
        ca-certificates \
        bzip2 \
        libfontconfig \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

RUN apt-get update \
    && apt-get install -y --no-install-recommends \
        curl \
    && mkdir /tmp/phantomjs \
    && curl -L https://bitbucket.org/ariya/phantomjs/downloads/phantomjs-2.1.1-linux-x86_64.tar.bz2 \
           | tar -xj --strip-components=1 -C /tmp/phantomjs \
    && cd /tmp/phantomjs \
    && mv bin/phantomjs /usr/local/bin \
    && cd \
    && apt-get purge --auto-remove -y \
        curl \
    && apt-get clean \
    && rm -rf /tmp/* /var/lib/apt/lists/*

# Run as non-root user 
RUN useradd --system --uid 72379 -m --shell /usr/sbin/nologin phantomjs

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
    webshot \
    ## clean up
    && rm -rf /tmp/downloaded_packages/ /tmp/*.rds

RUN R --vanilla -e "shinytest::installDependencies()"

COPY . $HOME/src/

WORKDIR $HOME/src/

RUN R CMD build .

RUN R CMD check *tar.gz

