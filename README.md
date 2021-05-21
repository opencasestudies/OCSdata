# OCSdata

### Access Data from [Open Case Studies](https://www.opencasestudies.org/)

OCSdata is an R package to help you access and download the data files used in a particular case study. The package provides several different functions to enable users to grab the data they need at different sections in the case study, as well as download the whole case study repository. All the user needs to do is input the name of the case study being worked on. The package relies on the `GET()` function from [httr](https://cran.r-project.org/web/packages/httr/index.html) to access files through the GitHub API. The functions `use_zip()` and `create_from_github()`from [usethis](https://usethis.r-lib.org/) are used to clone and/or download the case study repositories. 

## Installation 

```R
# install.packages("devtools")
devtools::install_github("opencasestudies/OCSdata")
```

## Examples

These examples assume you'd like to download the data files into your current working directory. If you'd like to download them elsewhere, specify the directory to save files to in the `outpath` argument. 
