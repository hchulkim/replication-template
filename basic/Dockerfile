FROM rocker/r-ver:4.3.0

LABEL maintainer="Hyoungchul Kim <hchul.kim96@gmail.com>"

## Go to main project root
WORKDIR /basic

# Install renv and then instatiate R environment
RUN R -e "install.packages('renv', repos = c(CRAN = 'https://cloud.r-project.org'))"

## Copy over the rest of the data and scripts
COPY . .

## Make sure we start in bash
CMD ["bash"]
