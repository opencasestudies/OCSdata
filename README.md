# OCSdata <img src='https://raw.githubusercontent.com/mbreshock/images/master/OCS_stickers/OCSdata_hexsticker_bold.png' align="right" height="160" />
<!-- badges: start -->
[![R_cmd_check](https://github.com/mbreshock/OCSdata/actions/workflows/check-standard.yaml/badge.svg)](https://github.com/opencasestudies/OCSdata/actions)
[![CRAN status](https://www.r-pkg.org/badges/version/OCSdata)](https://CRAN.R-project.org/package=OCSdata)
[![Downloads](http://cranlogs.r-pkg.org/badges/grand-total/OCSdata)](https://cran.r-project.org/package=OCSdata)
[![DOI](https://zenodo.org/badge/DOI/10.5281/zenodo.5214347.svg)](https://doi.org/10.5281/zenodo.5214347)
[![Codecov test coverage](https://codecov.io/gh/opencasestudies/OCSdata/branch/master/graph/badge.svg)](https://codecov.io/gh/opencasestudies/OCSdata?branch=master)
[![Lifecycle: stable](https://img.shields.io/badge/lifecycle-stable-brightgreen.svg)](https://lifecycle.r-lib.org/articles/stages.html#stable)
<!-- badges: end -->

### Download Data from [Open Case Studies (OCS)](https://www.opencasestudies.org/)

OCSdata is an R package to help you access and download case study data files hosted on the [OCS GitHub](https://github.com/opencasestudies). The package provides several different functions to enable users to grab the data they need at different sections in the case study, as well as download the whole case study repository. All the user needs to use the package is the name of the case study repository and a file path to the directory where the data should be saved. The package relies on the `GET()` function from [httr](https://cran.r-project.org/package=httr) to access files through the GitHub API. The functions `use_zip()` and `create_from_github()` from [usethis](https://usethis.r-lib.org/) are used to clone and/or download the case study repositories. 

## Installation 
Download the current release version from CRAN: 
```R
install.packages("OCSdata")
```

Download the current development version from GitHub: 
```R
# install.packages("devtools")
devtools::install_github("opencasestudies/OCSdata")
```

We are collecting data to improve the Open Case Studies. If you've used this package or any case study please take our [survey!](https://docs.google.com/forms/d/e/1FAIpQLSfpN4FN3KELqBNEgf2Atpi7Wy7Nqy2beSkFQINL7Y5sAMV5_w/viewform?usp=sf_link)

## Examples

These examples download the data files to temporary directories to avoid 
overwriting local files. If you'd like to save the files elsewhere, 
specify the file path to the desired download location in the `outpath` argument.
Or, leave the argument blank to interactively specify a directory with the R console. 

```R
library(OCSdata)

# Starting at data import section:
raw_data("ocs-bp-opioid-rural-urban", outpath = tempdir())

# for raw data in file formats that are easier to import, run:
simpler_import_data("ocs-bp-opioid-rural-urban", outpath = tempdir())

# Starting at data exploration/wrangling sections: 
imported_data("ocs-bp-opioid-rural-urban", outpath = tempdir())

# Starting at data visualization/analysis sections:
# for files in CSV format: 
wrangled_csv("ocs-bp-opioid-rural-urban", outpath = tempdir())

# for files in RDA format: 
wrangled_rda("ocs-bp-opioid-rural-urban", outpath = tempdir())

# Looking for more data on this topic: 
extra_data("ocs-bp-opioid-rural-urban", outpath = tempdir())

# Download repository in a zip file: 
zip_ocs("ocs-bp-opioid-rural-urban", outpath = tempdir())

# Clone the case study GitHub repository (requires registered PAT): 
clone_ocs("ocs-bp-opioid-rural-urban", outpath = tempdir(), fork_repo = TRUE)

# Setting fork_repo = TRUE will fork the repo first and then clone the fork, 
# while FALSE will clone the repo directly from the Open Case Studies GitHub. 
# The default is fork_repo = NA, which will fork or clone based on your repository 
# permissions. This function requires your personal GitHub PAT to be registered in RStudio. 

```
*Note: The default argument for* `outpath` *will trigger an interactive session* 
*where the user confirms the download location.*

These examples use the [Opioids in United States](https://github.com/opencasestudies/ocs-bp-opioid-rural-urban) case study, but you can use these functions with any of our case studies. Make sure to use the **Case Study ID** for the `casestudy` argument. See below to find your case study's ID:

| Case Study Name | Case Study ID |  
| --------------- | ------------- |
| [Exploring global patterns of obesity across rural and urban regions](https://www.opencasestudies.org/ocs-bp-rural-and-urban-obesity/) | [ocs-bp-rural-and-urban-obesity](https://github.com/opencasestudies/ocs-bp-rural-and-urban-obesity) |
| [Predicting Annual Air Pollution](https://www.opencasestudies.org/ocs-bp-air-pollution/) | [ocs-bp-air-pollution](https://github.com/opencasestudies/ocs-bp-air-pollution) |
| [Vaping Behaviors in American Youth](https://www.opencasestudies.org/ocs-bp-vaping-case-study/) | [ocs-bp-vaping-case-study](https://github.com/opencasestudies/ocs-bp-vaping-case-study) |
| [Opioids in United States](https://www.opencasestudies.org/ocs-bp-opioid-rural-urban/) | [ocs-bp-opioid-rural-urban](https://github.com/opencasestudies/ocs-bp-opioid-rural-urban) |
| [Influence of Multicollinearity on Measured Impact of Right-to-Carry Gun Laws Part 1](https://www.opencasestudies.org/ocs-bp-RTC-wrangling/) | [ocs-bp-RTC-wrangling](https://github.com/opencasestudies/ocs-bp-RTC-wrangling) |
| [Influence of Multicollinearity on Measured Impact of Right-to-Carry Gun Laws Part 2](https://www.opencasestudies.org/ocs-bp-RTC-analysis/) | [ocs-bp-RTC-analysis](https://github.com/opencasestudies/ocs-bp-RTC-analysis) |
| [Disparities in Youth Disconnection](https://www.opencasestudies.org/ocs-bp-youth-disconnection/) | [ocs-bp-youth-disconnection](https://github.com/opencasestudies/ocs-bp-youth-disconnection) |
| [Mental Health of American Youth](https://www.opencasestudies.org/ocs-bp-youth-mental-health/) | [ocs-bp-youth-mental-health](https://github.com/opencasestudies/ocs-bp-youth-mental-health) |
| [School Shootings in the United States](https://www.opencasestudies.org/ocs-bp-school-shootings-dashboard/) | [ocs-bp-school-shootings-dashboard](https://github.com/opencasestudies/ocs-bp-school-shootings-dashboard) |
| [Exploring CO2 emissions across time](https://www.opencasestudies.org/ocs-bp-co2-emissions/) | [ocs-bp-co2-emissions](https://github.com/opencasestudies/ocs-bp-co2-emissions) |
| [Exploring global patterns of dietary behaviors associated with health risk](https://www.opencasestudies.org/ocs-bp-diet/) | [ocs-bp-diet](https://github.com/opencasestudies/ocs-bp-diet) |


## Why Use OCSdata?

All case study data are available in the respective [OCS GitHub](https://github.com/opencasestudies) repositories. However, case study users new to GitHub can find it a confusing process to access data from repositories. On top of that, users then must move the downloaded data to the appropriate local directory. Overall, this process leaves room for error and acts as a barrier to introductory level students. Troubleshooting these errors can be a headache for both students and instructors and eats away at valuable learning time. OCSdata is an R package that bridges the gap from web-browser to Rstudio, allowing users to automatically download the data they need with simple functions all within R. 

This package is licensed under the terms of the MIT license.
