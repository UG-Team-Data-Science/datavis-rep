options(
  repos = c(CRAN = "https://cloud.r-project.org"),
  Ncpus = max(1L, parallel::detectCores() - 1L)
)

cran_packages <- c(
  # Core data/plotting ecosystem
  "tidyverse", "ggplot2", "plotly", "gganimate", "patchwork",
  "ggthemes", "ggforce", "ggridges", "ggrepel", "ggfortify",
  "ggfittext", "ggstance", "ggimage", "cowplot", "gridExtra",
  "treemapify", "hexbin", "plot3D", "misc3d", "rgl",
  "maps", "RColorBrewer", "viridis", "scales", "ggplot2movies",

  # Spatial visualization stack
  "sf", "sp", "rgeos", "maptools", "geofacet",
  "rnaturalearth", "rworldmap", "statebins", "ggspatial", "ggmap",

  # Statistical and multivariate visualization
  "MASS", "e1071", "caret", "GGally", "vcd", "FactoMineR",

  # Time-series visualization
  "timeSeries", "zoo", "xts", "forecast", "tsibble",
  "fable", "fabletools", "timetk",

  # Notebook/reporting and web visualization helpers
  "IRkernel", "knitr", "rmarkdown", "htmlwidgets", "r2d3",
  "yaml", "jsonlite", "httr", "curl", "xml2", "rvest",

  # Data import and utilities
  "haven", "foreign", "data.table", "pillar", "hms",
  "stringi", "glue", "cli", "crayon"
)

install_one <- function(pkg) {
  if (requireNamespace(pkg, quietly = TRUE)) {
    message(sprintf("[skip] %s already installed", pkg))
    return(TRUE)
  }
  message(sprintf("[install] %s", pkg))
  tryCatch({
    install.packages(pkg, dependencies = TRUE)
    TRUE
  }, error = function(e) {
    message(sprintf("[warn] failed to install %s: %s", pkg, conditionMessage(e)))
    FALSE
  })
}

results <- vapply(cran_packages, install_one, logical(1))
failed_cran <- cran_packages[!results]

if (length(failed_cran) > 0) {
  warning(sprintf(
    "Some CRAN packages failed to install (%d): %s",
    length(failed_cran),
    paste(failed_cran, collapse = ", ")
  ))
}

# GitHub installs are optional because they are slower and can be flaky on Binder.
# Enable with INSTALL_GITHUB_PACKAGES=1 when you need them.
if (identical(Sys.getenv("INSTALL_GITHUB_PACKAGES", "0"), "1")) {
  if (!requireNamespace("remotes", quietly = TRUE)) {
    install.packages("remotes")
  }

  github_packages <- c(
    "clauswilke/colorblindr",
    "clauswilke/dviz.supp",
    "wilkelab/cowplot",
    "wilkelab/ggtext",
    "DavisVaughan/strapgod"
  )

  for (pkg in github_packages) {
    message(sprintf("[github] %s", pkg))
    tryCatch(
      remotes::install_github(pkg, upgrade = "never"),
      error = function(e) message(sprintf("[warn] failed to install %s: %s", pkg, conditionMessage(e)))
    )
  }
} else {
  message("Skipping GitHub R packages (set INSTALL_GITHUB_PACKAGES=1 to enable).")
}
