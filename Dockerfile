# Use jupyter/datascience-notebook as the base image
# This provides JupyterLab with Python, R, and basic data science packages
FROM jupyter/datascience-notebook:latest

# Set environment variables
ENV NB_USER jovyan
ENV NB_UID 1000
ENV NB_GID 100

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

# Install Octave packages for plotting
RUN octave --no-window-system --eval "pkg install -forge plot image io statistics" \
    && octave --no-window-system --eval "pkg load plot; pkg load image; pkg load io; pkg load statistics"

# Install Julia packages for plotting
RUN julia -e 'using Pkg; Pkg.add([\"Plots\", \"GR\", \"PlotlyJS\", \"Makie\"])'

# Switch back to jovyan user
USER ${NB_USER}

# Copy configuration files
COPY requirements.txt install.R /tmp/

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
