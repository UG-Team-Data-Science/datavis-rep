# Work Directory

Add your own datasets, notebooks, and code here.

## How to Use

1. **Add your files**: Place your Jupyter notebooks, Python scripts, R scripts, or datasets in this directory
2. **Launch Binder**: Click the Binder badge in the main README to start a session
3. **Access your files**: They will be available at `/home/jovyan/work` inside the container

## Supported File Types

- **Jupyter Notebooks**: `.ipynb`
- **Python scripts**: `.py`
- **R scripts**: `.R`, `.Rmd`
- **Julia scripts**: `.jl`
- **Octave scripts**: `.m`
- **Data files**: `.csv`, `.json`, `.parquet`, etc.

## Notes

- This directory is **mounted** into the Docker container, so changes persist across sessions
- The environment comes with **no datasets or sample code** - you provide your own
- All visualization libraries are pre-installed and ready to use

## Included D3 examples

- `d3_in_jupyter_demo.ipynb`: D3.js rendered inside a notebook output cell.
- `apps/d3-scatter/index.html`: Standalone D3.js scatter plot app.
