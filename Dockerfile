FROM rocker/r-ver:4.5.1

RUN apt-get update && apt-get install -y \
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
    wget \
    pandoc

RUN R -e "install.packages('remotes')"

RUN R -e "remotes::install_github('rstudio/renv@v1.1.5')"

RUN mkdir /home/project

COPY renv.lock /home/project/renv.lock

RUN R -e "setwd('/home/project');renv::restore()"

RUN mkdir /home/project/output

RUN mkdir /home/project/shared_folder

RUN cd /home/project/output && touch test.txt

RUN echo "testing!" >> /home/project/output/test.txt

CMD mv /home/project/output/* /home/project/shared_folder/
