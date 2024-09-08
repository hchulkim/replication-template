FROM rocker/r-ver:4.4.0

LABEL maintainer="Hyoungchul Kim <hchul.kim96@gmail.com>"

## Update and install system dependencies
RUN apt-get update && apt-get install -y \
	libcurl4-openssl-dev \
	libssl-dev \
	libfontconfig1-dev \
	libharfbuzz-dev \
	libfribidi-dev \
	libfreetype6-dev \
	libpng-dev \
	libtiff5-dev \
	libjpeg-dev \
	libglpk-dev \
	libxml2-dev \
	libcairo2-dev \
	libgit2-dev \
	libpq-dev \
	libsasl2-dev \
	libsqlite3-dev \
	libssh2-1-dev \
	libxt-dev

## Install Pandoc
RUN /rocker_scripts/install_pandoc.sh

## Install Python /reticulate
RUN /rocker_scripts/install_python.sh

## Install numpy
RUN pip3 install numpy

## Go to main project root
WORKDIR /basic

## Copy renv.lock file into the folder
COPY renv.lock .

# Set environment variables for renv to avoid bootstrapping issues
ENV RENV_VERSION 1.0.7
ENV RENV_PATHS_CACHE /renv/cache
ENV RENV_CONFIG_REPOS_OVERRIDE https://cloud.r-project.org
ENV RENV_CONFIG_AUTOLOADER_ENABLED FALSE
ENV RENV_WATCHDOG_ENABLED FALSE

# Install renv from CRAN (avoiding bootstrapping by specifying version)
RUN R -e "install.packages('renv', repos = c(CRAN = 'https://cloud.r-project.org'))"
RUN R -e "renv::consent(provided = TRUE)"

# Run renv restore to restore the environment
RUN R -e "renv::restore()"

## Copy over the rest of the data and scripts
COPY . .

## Make sure we start in bash
CMD ["bash"]

