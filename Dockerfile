FROM rocker/binder:latest

# Set environment variables
ENV NB_USER=jovyan
ENV NB_UID=1000
ENV NB_GID=100

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

# Octave add-on packages are installed through apt.txt to keep Binder builds deterministic.

# Install Julia visualization packages (no AI tooling).
RUN julia -e 'using Pkg; Pkg.add(["IJulia", "Plots", "GR", "VegaLite"]); for pkg in ["PlotlyJS", "Makie"]; try; Pkg.add(pkg); catch err; @warn "Skipping optional Julia package" package=pkg exception=err; end; end'

# Switch back to jovyan user
USER ${NB_USER}

# Copy configuration files
COPY requirements.txt install.R /tmp/

# Install Python packages and enable notebook puller extension.
RUN pip install --no-cache-dir --requirement /tmp/requirements.txt \
    && jupyter server extension enable --py nbgitpuller --sys-prefix

# Install R packages
RUN Rscript /tmp/install.R

# Clean up
USER root
RUN rm -f /tmp/requirements.txt /tmp/install.R /tmp/apt.txt
USER ${NB_USER}

# Set working directory
WORKDIR /home/${NB_USER}/work

# Expose Jupyter port
EXPOSE 8888
