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
    cmake \
    git \
    wget \
    pandoc \
    graphviz \
    make \
    makefile2graph && \
    rm -rf /var/lib/apt/lists/*

# R tooling
RUN R -e "install.packages('remotes')"
RUN R -e "remotes::install_github('rstudio/renv@v1.1.5')"

# Project
WORKDIR /home/project
RUN mkdir -p output shared_folder

# Restore via lockfile first for better caching
COPY renv.lock renv.lock
RUN R -e "renv::consent(provided=TRUE); renv::restore(prompt=FALSE)"

# Then copy the rest
COPY . .

RUN cd /home/project/output && touch version.txt

RUN echo "version: hchulkim/r_4.5.1" >> /home/project/output/version.txt

CMD mv /home/project/output/* /home/project/shared_folder/
