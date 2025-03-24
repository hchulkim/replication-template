## Use Rocker image as the base for R
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
    libxt-dev \
    libgdal-dev \
    wget \
    curl \
    vim \
    git	

## Install Pandoc and Quarto (Required for RMarkdown, Quarto, etc.)
# RUN /rocker_scripts/install_pandoc.sh
# RUN /rocker_scripts/install_quarto.sh

## Install Python & Poetry
RUN /rocker_scripts/install_python.sh && \
    pip3 install --upgrade pip && \
    pip3 install poetry

## Ensure Poetry installs dependencies in the system environment
RUN poetry config virtualenvs.create false

## Copy Poetry files and install dependencies
COPY pyproject.toml poetry.lock .
RUN poetry install --no-interaction --no-root

## Install Julia 1.11.3 (to match Manifest.toml)
ENV JULIA_VERSION=1.11.3
RUN /rocker_scripts/install_julia.sh

## Set working directory
WORKDIR /project

## Copy renv.lock file into the folder
COPY renv.lock .

## Set environment variables for renv
ENV RENV_VERSION=1.0.7
ENV RENV_PATHS_CACHE=/renv/cache
ENV RENV_CONFIG_REPOS_OVERRIDE=https://cloud.r-project.org
ENV RENV_CONFIG_AUTOLOADER_ENABLED=FALSE
ENV RENV_WATCHDOG_ENABLED=FALSE
RUN echo "options(renv.consent = TRUE)" >> .Rprofile
RUN echo "options(RETICULATE_MINICONDA_ENABLED = FALSE)" >> .Rprofile

## Install renv from CRAN (avoiding bootstrapping by specifying version)
RUN R -e "install.packages('renv', repos = c(CRAN = 'https://cloud.r-project.org'))"
RUN R -e "renv::consent(provided = TRUE)"

# Run renv restore to restore the environment
RUN R -e "renv::restore(confirm = FALSE)"

## Install Julia packages and manage dependencies
COPY Manifest.toml Project.toml .
ENV JULIA_PROJECT=/project
RUN julia -e "import Pkg; Pkg.activate(\".\"); Pkg.instantiate()"

## Copy over the rest of the project files
COPY . .

## Default command
CMD ["bash"]

