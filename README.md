# Data Visualization Environment (datavis-rep)

A **Binder-ready** and **GitHub Codespaces-compatible** environment for data visualization using **Python, R, Octave, and Julia**.

This repository provides a pre-configured environment with all necessary packages for data visualization across multiple languages, without any AI tools or datasets.

---

## 🚀 Quick Start

### **Option 1: Launch in Binder (MyBinder)**

[![Binder](https://mybinder.org/badge_logo.svg)](https://mybinder.org/v2/gh/your-username/datavis-rep/HEAD?urlpath=lab)

Click the badge above to launch the environment in **MyBinder**. This will:
- Build the Docker container using `jupyter/datascience-notebook` as the base
- Install all Python packages from `requirements.txt`
- Install all R packages from `install.R`
- Install Octave and Julia with plotting capabilities

Once launched, you'll have access to:
- **JupyterLab** with Python, R, Octave, and Julia kernels
- All visualization libraries pre-installed
- A clean workspace to add your own datasets and code

### **Option 2: GitHub Codespaces**

1. Open this repository in GitHub
2. Click the **Code** button
3. Select the **Codespaces** tab
4. Click **Create codespace on main**

The environment will automatically:
- Build the Docker container
- Install all dependencies
- Start Jupyter Lab on port 8888

Once the codespace is ready:
- Open the **Ports** tab to access Jupyter Lab
- Or run `jupyter lab` in the terminal

### **Option 3: Local Development**

```bash
# Clone the repository
git clone https://github.com/your-username/datavis-rep.git
cd datavis-rep

# Build and run with Docker
docker build -t datavis-rep .
docker run -p 8888:8888 -v $(pwd):/home/jovyan/work datavis-rep

# Or use docker-compose
docker-compose up -d
```

Then open `http://localhost:8888` in your browser.

---

## 📦 Included Components

### **Base Image**
- `jupyter/datascience-notebook:latest` - Provides JupyterLab with Python, R, and Julia pre-installed

### **Languages & Kernels**
| Language | Version | Kernel | Status |
|----------|---------|--------|--------|
| Python | 3.x | ipykernel | ✅ |
| R | 4.x | IRkernel | ✅ |
| Octave | Latest | octave-kernel | ✅ |
| Julia | From base image | IJulia | ✅ |

### **Python Packages**
Core visualization and data science libraries:
- **Plotting**: seaborn, altair, plotly, plotnine, matplotlib
- **Data**: pandas, numpy, scipy
- **ML**: scikit-learn
- **Jupyter**: ipywidgets

See `requirements.txt` for the full list.

### **R Packages**
Comprehensive R visualization ecosystem:
- **Tidyverse**: dplyr, tidyr, ggplot2, tibble, purrr, stringr
- **Advanced Plotting**: plotly, gganimate, patchwork, ggforce, ggridges
- **Spatial**: sf, rgeos, sp, maptools, rnaturalearth
- **Themes**: ggthemes, cowplot, colorblindr
- **Utilities**: knitr, rmarkdown, jsonlite, httr

See `install.R` for the full list.

### **Octave Packages**
- plot - Plotting functions
- image - Image processing
- io - Input/Output
- statistics - Statistical functions

### **Julia Packages**
- Plots.jl - Meta-package for plotting
- GR.jl - Backend for Plots
- PlotlyJS.jl - Plotly-based plotting
- Makie.jl - High-level plotting library

---

## 🛠️ Customization

### **Using D3.js in Jupyter**
Yes. D3.js can run in Jupyter notebooks by rendering HTML/JavaScript output.

Included examples:
- Notebook demo: `work/d3_in_jupyter_demo.ipynb`
- Standalone app: `work/apps/d3-scatter/index.html`

How to run:
1. Open `work/d3_in_jupyter_demo.ipynb` in JupyterLab and run the code cell.
2. Open `work/apps/d3-scatter/index.html` in JupyterLab to view the standalone D3 app.

### **Adding Your Own Code**
1. Clone this repository
2. Add your notebooks, scripts, or datasets to the repository
3. Push to GitHub
4. Launch in Binder or Codespaces

### **Adding New Packages**
- **Python**: Add to `requirements.txt`
- **R**: Add to `install.R`
- **Octave**: Add to the Octave installation command in `Dockerfile`
- **Julia**: Add to the Julia Pkg.add command in `Dockerfile`

Then rebuild the Docker container.

### **Adding System Dependencies**
Add package names to `apt.txt` and update the `Dockerfile` accordingly.

---

## 📝 Notes


### **Binder Limitations**
- Binder sessions are temporary and will be deleted after inactivity
- Session timeout: 10 minutes of inactivity
- Maximum session duration: 24 hours

### **Codespaces Limitations**
- Free tier has limited compute and storage
- Paid plans required for extended usage

---

## 📄 Files in This Repository

| File | Purpose |
|------|---------|
| `Dockerfile` | Docker configuration using jupyter/datascience-notebook as base |
| `requirements.txt` | Python packages to install |
| `install.R` | R packages to install |
| `apt.txt` | System dependencies to install |
| `work/d3_in_jupyter_demo.ipynb` | Jupyter notebook showing D3.js rendering via HTML/JS |
| `work/apps/d3-scatter/index.html` | Standalone D3.js scatter plot app |
| `.devcontainer/devcontainer.json` | GitHub Codespaces configuration |
| `.devcontainer/docker-compose.yml` | Docker Compose for Codespaces |
| `README.md` | This file |

---

## 🤝 Contributing

1. Fork this repository
2. Create a feature branch
3. Make your changes
4. Submit a pull request

---

## 📜 License

TBA

---

## 🙌 Acknowledgments

- Uses `jupyter/datascience-notebook` as the base image
