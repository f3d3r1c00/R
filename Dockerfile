FROM ubuntu:xenial
# Install system dependencies for R
RUN apt update -qq && \
    DEBIAN_FRONTEND=noninteractive apt install -y \
    apt-transport-https \
    build-essential \
    curl \
    gfortran \
    libatlas-base-dev \
    libbz2-dev \
    libcairo2 \
    libcurl4-openssl-dev \
    libicu-dev \
    liblzma-dev \
    libpango-1.0-0 \
    libpangocairo-1.0-0 \
    libpcre3-dev \
    libtcl8.6 \
    libtiff5 \
    libtk8.6 \
    libx11-6 \
    libxt6 \
    locales \
    tzdata \
    zlib1g-dev
    
# Install system dependencies for the tidyverse R packages
RUN apt install -y \
    make \
    libcurl4-openssl-dev \
    libssl-dev \
    pandoc \
    libxml2-dev

# R can be added to a Docker image in one of three ways:
FROM rstudio/r-base:3.5-xenial

# download a version of R and build from source
ARG R_VERSION=3.5.2
RUN wget https://cdn.rstudio.com/r/ubuntu-1604/pkgs/r-${R_VERSION}_1_amd64.deb
RUN apt-get install -y gdebi-core
RUN gdebi r-${R_VERSION}_1_amd64.deb

#R Packages
# pull in a manifest file and restore it
COPY renv.lock ./
RUN R -e 'renv::restore()'

#Code
RUN git clone https://git.company.com/jane/code.git
#Data
RUN git clone https://git.company.com/jane/data.git


