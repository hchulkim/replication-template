FROM rocker/r-ver:4.5.1

# System deps
RUN apt-get update && apt-get install -y --no-install-recommends \
    build-essential \
    gfortran \
    pkg-config \
    libssl-dev \
    libglpk-dev \
    libxml2-dev \
    libcairo2-dev \
    libgit2-dev \
    default-libmysqlclient-dev \
    libpq-dev \
    libsasl2-dev \
    libsqlite3-dev \
    libssh2-1-dev \
    libxtst6 \
    libcurl4-openssl-dev \
    libharfbuzz-dev \
    libfribidi-dev \
    libfreetype6-dev \
    libpng-dev \
    libtiff5-dev \
    libjpeg-dev \
    libxt-dev \
    unixodbc-dev \
    gdal-bin \
    libgdal-dev \
    libgeos-dev \
    libproj-dev \
    libudunits2-dev \
    ca-certificates \
    tar \
    cmake \
    git \
    wget \
    curl \
    perl \
    pandoc \
    graphviz \
    make \
    makefile2graph && \
    rm -rf /var/lib/apt/lists/*

# Install renv R package
RUN R -e "install.packages('remotes')"
RUN R -e "remotes::install_github('rstudio/renv@v1.1.5')"

# Set working directory for the project
WORKDIR /home/project
