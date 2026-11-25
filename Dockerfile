# Use jupyter/datascience-notebook as the base image
# This provides JupyterLab with Python, R, and basic data science packages
FROM jupyter/datascience-notebook:latest

# Set environment variables
ENV NB_USER jovyan
ENV NB_UID 1000
ENV NB_GID 100

# Switch to root for installing system dependencies
USER root

# Install system dependencies for Octave and plotting
RUN apt-get update && apt-get install -y --no-install-recommends \
    # Octave and dependencies
    octave \
    octave-plotting \
    gnuplot \
    # General plotting and graphics
    libudunits2-dev \
    libpoppler-cpp-dev \
    gdal-bin \
    libgdal-dev \
    libgeos-dev \
    libproj-dev \
    libmagick++-dev \
    libxt6 \
    libxtst6 \
    ghostscript \
    poppler-utils \
    texlive-latex-extra \
    # Clean up
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Install Octave packages for plotting
RUN octave --no-window-system --eval "pkg install -forge plot image io statistics" \
    && octave --no-window-system --eval "pkg load plot; pkg load image; pkg load io; pkg load statistics"

# Install Julia packages for plotting
RUN julia -e 'using Pkg; Pkg.add([\"Plots\", \"GR\", \"PlotlyJS\", \"Makie\"])'

# Switch back to jovyan user
USER ${NB_USER}

# Copy configuration files
COPY requirements.txt install.R apt.txt /tmp/

# Install Python packages
RUN pip install --no-cache-dir --requirement /tmp/requirements.txt

# Install R packages
RUN Rscript /tmp/install.R

# Clean up
RUN rm -f /tmp/requirements.txt /tmp/install.R /tmp/apt.txt

# Set working directory
WORKDIR /home/${NB_USER}/work

# Expose Jupyter port
EXPOSE 8888
