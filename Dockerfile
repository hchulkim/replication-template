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
    
# Install renv R package (stable version)
# ARG RENV_VERSION=1.1.5
RUN R -e "install.packages('remotes')"
# RUN R -e "remotes::install_github('rstudio/renv@v${RENV_VERSION}')"

# Install develpment R package (less stable version)
RUN R -e "install.packages('renv', repos = 'https://rstudio.r-universe.dev')"

# Setup setting for renv package: DO NOT USE IT HERE! Use it when you do renv::restore() is your Dockerfile
# ENV RENV_CONFIG_RSPM_ENABLED=TRUE
# ENV RENV_CONFIG_REPOS_OVERRIDE=REPOS LINK


# Set working directory for the project
WORKDIR /home/project
