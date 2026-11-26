options(repos = c(CRAN = "https://cloud.r-project.org"))

# Core tidyverse and ggplot2
install.packages(c("tidyverse", "ggplot2", "dplyr", "tidyr", "tibble", "purrr", 
                    "stringr", "forcats", "readr", "readxl", "lubridate"))

# Data visualization packages
install.packages(c("ggrepel", "ggthemes", "ggforce", "ggridges", "patchwork",
                    "ggspatial", "ggmap", "maps", "RColorBrewer", "viridis",
                    "ggfortify", "ggstance", "ggfittext", "cowplot",
                    "colorblindr", "ggtextures", "ungeviz"))

# Advanced plotting
install.packages(c("plotly", "htmlwidgets", "gganimate", "ggexchange",
                    "treemapify", "hexbin", "plot3D", "misc3d", "rgl",
                    "ggplot2movies", "ggimage", "gridExtra"))

# Spatial data
install.packages(c("sf", "rgeos", "sp", "maptools", "geofacet",
                    "rnaturalearth", "rworldmap", "statebins"))

# Statistical visualization
install.packages(c("MASS", "e1071", "caret", "GGally", "vcd",
                    "FactoMineR", "tidymodels"))

# Time-series analysis and visualization
install.packages(c("timeSeries", "zoo", "xts", "forecast", "tsibble",
                    "fable", "fabletools", "timetk"))

# Utilities
install.packages(c("knitr", "rmarkdown", "bookdown", "yaml", "jsonlite",
                    "httr", "curl", "xml2", "rvest", "haven",
                    "foreign", "readr", "data.table", "pillar",
                    "hms", "stringi", "glue", "cli", "crayon"))

# Install from GitHub (if needed)
if (!requireNamespace("remotes", quietly = TRUE)) {
  install.packages("remotes")
}

# Additional visualization packages from GitHub
remotes::install_github('clauswilke/colorblindr')
remotes::install_github('clauswilke/dviz.supp')
remotes::install_github('wilkelab/cowplot')
remotes::install_github('wilkelab/ggtext')
remotes::install_github('DavisVaughan/strapgod')
