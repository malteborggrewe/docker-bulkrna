# Use an R-based image (R 4.3.2)
FROM rocker/r-ver:4.3.2

# Install system libraries
RUN apt-get update && apt-get install -y \
    python3-pip \
    libglpk40 \
    libglpk-dev \
    libzmq3-dev \
    libgsl-dev \
    zlib1g-dev \
    libbz2-dev \
    liblzma-dev \
    libcurl4-openssl-dev \
    libssl-dev \
    libxml2-dev \
    libhdf5-dev \
    && apt-get clean

# Install quarto
RUN apt-get update && apt-get install -y \
    curl \
    && curl -LO https://quarto.org/download/latest/quarto-linux-amd64.deb \
    && apt-get install -y ./quarto-linux-amd64.deb \
    && rm quarto-linux-amd64.deb

# Install base python packages
RUN pip3 install jupyter ipykernel

# Set the working directory
WORKDIR /analysis

# Copy the renv.lock and pyproject.toml files from your host into the container
COPY renv.lock /analysis/

# Install important R packages for jupyter and others
RUN R -e "install.packages(c('renv', 'IRkernel', 'languageserver', 'rmarkdown'))"
# Activate Jupyter R Kernel
RUN Rscript -e "IRkernel::installspec(user = FALSE)"

# Install R packages using renv (restore R environment)
RUN R -e "renv::restore()"
RUN R -e "renv::activate()"

# Keep container running
CMD ["bash"]
