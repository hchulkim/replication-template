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


# ---

## This is a more full version of dockerfile. I leave this here as reference.


FROM rocker/r-ver:4.0.2

LABEL maintainer="Grant McDermott <grantmcd@uoregon.edu>"

## Install Pandoc
RUN /rocker_scripts/install_pandoc.sh

## Install Python / reticulate
RUN /rocker_scripts/install_python.sh
## Install scipy
RUN pip3 install scipy==1.5.1

## Optional/extra: graphviz & makefile2graph for Make DAG
RUN apt-get update && apt-get install -y --no-install-recommends \
    git-core \
    graphviz
RUN git clone https://github.com/lindenb/makefile2graph.git
WORKDIR /makefile2graph
RUN make
# RUN make install ## Not sure why but this is generating build errors

## Install Julia. We'll use Abel Siqueira's handy JILL script to do this.
RUN wget https://raw.githubusercontent.com/abelsiqueira/jill/master/jill.sh
RUN bash jill.sh --no-confirm --version 1.5.0

## Go to main project root
WORKDIR /sceptic-priors

# Install renv and then instantiate R environment (also install cmdstan)
COPY renv.lock .
ENV RENV_VERSION 0.12.0
RUN echo "options(renv.consent = TRUE)" >> .Rprofile
RUN echo "options(RETICULATE_MINICONDA_ENABLED = FALSE)" >> .Rprofile
RUN R -e "install.packages('remotes')"
RUN R -e "remotes::install_github('rstudio/renv@${RENV_VERSION}')"
RUN R -e "install.packages('renv')"
RUN R -e "renv::restore(confirm = FALSE)"
RUN R -e "cmdstanr::install_cmdstan(version = '2.25.0', cores = 2)"

## Extra steps needed for RCall library (Julia)
ENV LD_LIBRARY_PATH="/usr/local/lib/R/lib"
RUN cp /usr/lib/x86_64-linux-gnu/libstdc++.so.6 /opt/julias/julia-1.5.0/lib/julia

## Set up Julia environment and precompile libraries
COPY *.toml ./
RUN julia -e 'using Pkg; Pkg.Registry.add("General")'
RUN julia -e 'using Pkg; Pkg.Registry.add(RegistrySpec(url = "https://github.com/mimiframework/MimiRegistry.git"))'
RUN julia -e 'using Pkg; Pkg.activate("."); Pkg.instantiate(); Pkg.precompile()'

## Copy over the rest of the data and scripts
COPY . .

## Make sure we start in bash
CMD ["bash"]



