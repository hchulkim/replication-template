FROM hchulkim/r_4.5.1:latest

ARG TARGETARCH
ENV ARCH_TYPE=${TARGETARCH}

# Quarto
ENV QUARTO_VERSION=1.7.32
RUN /rocker_scripts/install_quarto.sh

# --- TinyTeX install (arm64 manual, amd64 via Quarto) ---
RUN set -eux; \
  if [ "$ARCH_TYPE" = "arm64" ]; then \
    wget -qO- "https://yihui.org/tinytex/install-unx.sh" | sh -s - --admin --no-path; \
  else \
    quarto install tinytex; \
  fi

# Set TinyTeX path
ENV PATH="/root/.TinyTeX/bin/aarch64-linux:/root/.TinyTeX/bin/x86_64-linux:${PATH}"

# Set CTAN mirror for tlmgr
ENV TEXLIVE_REPOSITORY="https://ctan.math.illinois.edu/systems/texlive/tlnet"

# Set repo in tlmgr
RUN tlmgr option repository "$TEXLIVE_REPOSITORY"; \
  tlmgr update --self

# Install some R packages from source to avoid error
RUN R -q -e "install.packages('stringi', type='source', repos='https://cloud.r-project.org')"
RUN R -q -e "install.packages('sf', type='source', repos='https://cloud.r-project.org')"

# Restore via lockfile first for better caching
COPY renv.lock renv.lock
RUN R -e 'renv::consent(provided=TRUE); renv::restore(prompt=FALSE)'

# Julia
ENV JULIA_VERSION=1.11.6
RUN /rocker_scripts/install_julia.sh
RUN julia -e "import Pkg; Pkg.add(\"DrWatson\")"
COPY Manifest.toml Project.toml .
ENV JULIA_PROJECT=/home/project
RUN julia -e "import Pkg; Pkg.activate(\".\"); Pkg.instantiate()"

# Project files
COPY . .

RUN mkdir -p shared_folder

# Build DAG
RUN make dag && mv makefile-dag.png output/

# Run analysis
RUN make all

CMD ["sh", "-c", "cp -r /home/project/output/* /home/project/shared_folder/"]
