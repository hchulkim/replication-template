FROM rocker/r-ver:4.3.0

LABEL maintainer="Hyoungchul Kim <hchul.kim96@gmail.com>"

## Go to main project root
WORKDIR /project .

# Install renv and then instatiate R environment
COPY renv.lock .
ENV RENV_VERSION=0.12.0
RUN echo "options(renv.consent = TRUE)" >> .Rprofile
RUN R -e "install.packages('remotes')"
RUN R -e "remotes::install_github('rstudio/renv@${RENV_VERSION}')"
RUN R -e "install.packages('renv')"
RUN R -e "renv::restore(confirm = FALSE)"

## Copy over the rest of the data and scripts
COPY . .

## Make sure we start in bash
CMD ["bash"]






