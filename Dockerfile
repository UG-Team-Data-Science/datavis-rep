FROM rocker/binder:latest

# Set environment variables
ENV NB_USER=jovyan
ENV NB_UID=1000
ENV NB_GID=100
ARG JULIA_VERSION=1.10.10

# Switch to root for installing system dependencies
USER root

# Copy system dependency manifest
COPY apt.txt /tmp/apt.txt

# Install system dependencies from apt.txt
RUN apt-get update \
    && grep -Ev '^\s*($|#)' /tmp/apt.txt > /tmp/apt-packages.txt \
    && apt-get install -y --no-install-recommends $(cat /tmp/apt-packages.txt) \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* /tmp/apt-packages.txt

# Install Julia from the official binaries so Binder builds always have Julia.
RUN set -eux; \
        arch="$(dpkg --print-architecture)"; \
        case "$arch" in \
            amd64) julia_arch="x86_64"; julia_path="x64" ;; \
            arm64) julia_arch="aarch64"; julia_path="aarch64" ;; \
            *) echo "Unsupported architecture: $arch"; exit 1 ;; \
        esac; \
        julia_major_minor="$(echo "$JULIA_VERSION" | awk -F. '{print $1"."$2}')"; \
        julia_tgz="julia-${JULIA_VERSION}-linux-${julia_arch}.tar.gz"; \
        julia_url="https://julialang-s3.julialang.org/bin/linux/${julia_path}/${julia_major_minor}/${julia_tgz}"; \
        curl -fsSL "$julia_url" -o /tmp/julia.tar.gz; \
        tar -xzf /tmp/julia.tar.gz -C /opt; \
        ln -s /opt/julia-${JULIA_VERSION}/bin/julia /usr/local/bin/julia; \
        rm -f /tmp/julia.tar.gz

# Octave add-on packages are installed through apt.txt to keep Binder builds deterministic.

# Install Julia visualization packages.
RUN julia -e 'using Pkg; Pkg.add(["IJulia", "Plots", "GR", "VegaLite"]); for pkg in ["PlotlyJS", "Makie"]; try; Pkg.add(pkg); catch err; @warn "Skipping optional Julia package" package=pkg exception=err; end; end'

# Ensure Jupyter config is writable for NB_USER during extension setup.
RUN mkdir -p /home/${NB_USER}/.jupyter \
    && chown -R ${NB_USER}:users /home/${NB_USER}/.jupyter

# Switch back to jovyan user
USER ${NB_USER}

# Copy configuration files
COPY requirements.txt install.R /tmp/

# Install Python packages and enable notebook puller extension when installed.
RUN pip install --no-cache-dir --requirement /tmp/requirements.txt \
        && if python -c "import nbgitpuller" >/dev/null 2>&1; then \
                 jupyter server extension enable --py nbgitpuller --sys-prefix; \
             else \
                 echo "nbgitpuller is not installed; skipping extension enable."; \
             fi

# Install R packages
RUN INSTALL_GITHUB_PACKAGES=1 Rscript /tmp/install.R

# Ensure bookdown/knitr stack is present even if optional packages in install.R fail.
RUN Rscript -e 'options(repos = c(CRAN = "https://cloud.r-project.org")); install.packages(c("knitr", "rmarkdown", "bookdown", "xfun"), dependencies = TRUE)'

# Bundle repository teaching material in the image workspace.
USER root
COPY work/ /home/${NB_USER}/work/
RUN chown -R ${NB_USER}:users /home/${NB_USER}/work

# Clean up
RUN rm -f /tmp/requirements.txt /tmp/install.R /tmp/apt.txt
USER ${NB_USER}

# Set working directory
WORKDIR /home/${NB_USER}/work

# Expose Jupyter port
EXPOSE 8888
