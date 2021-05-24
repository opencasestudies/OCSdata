# OCSdata

### Download Data from [Open Case Studies](https://www.opencasestudies.org/)

OCSdata is an R package to help you access and download the case study data files hosted on the [OCS GitHub](https://github.com/opencasestudies). The package provides several different functions to enable users to grab the data they need at different sections in the case study, as well as download the whole case study repository. All the user needs to do is input the name of the case study being worked on. The package relies on the `GET()` function from [httr](https://cran.r-project.org/web/packages/httr/index.html) to access files through the GitHub API. The functions `use_zip()` and `create_from_github()`from [usethis](https://usethis.r-lib.org/) are used to clone and/or download the case study repositories. 

## Installation 

```R
# install.packages("devtools")
devtools::install_github("opencasestudies/OCSdata")
```

## Examples

These examples assume you'd like to download the data files into your current working directory. If you'd like to download them elsewhere, specify the desired directory in the `outpath` argument.

```R
library(OCSdata)

# Starting at data import section:
load_raw_data("ocs-bp-opioid-rural-urban", outpath = getwd())
# for file formats that are easier to import:
load_simpler_import("ocs-bp-opioid-rural-urban", outpath = getwd())

# Starting at data exploration/wrangling sections: 
load_imported_data("ocs-bp-opioid-rural-urban", outpath = getwd())

# Starting at data visualization/analysis sections:
load_wrangled_data("ocs-bp-opioid-rural-urban", outpath = getwd())

# Looking for more data on this topic: 
load_extra_data("ocs-bp-opioid-rural-urban", outpath = getwd())

# Download all repository files: 
load_repo("ocs-bp-opioid-rural-urban", outpath = getwd())

# Clone the case study GitHub repository: 
clone_ocs_repo("ocs-bp-opioid-rural-urban", outpath = getwd(), fork_repo = FALSE)
# Setting fork_repo = TRUE will fork the repo first and then clone the fork, 
# while FALSE will clone the repo directly from the Open Case Studies GitHub. 
# The default is fork_repo = NA, which will fork or clone based on your repository 
# permissions. This function requires your personal GitHub PAT to be registered in RStudio. 

```
*Note: The default argument for* `outpath` *will download the files to your current working directory.* `outpath = getwd()` *is redundant, but used here to illustrate that the download location can be specified.*

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

All of the case study data is accessible in their respective GitHub repositories. However, case study users new to GitHub can find it a confusing process to download data from GitHub. On top of that, users then must move the downloaded data into the local directory where they'd like to work on the case study. This can also be confusing to users new to R. Overall, this process leaves lots of room for error and acts as a barrier to introductory level students. Troubleshooting these errors can be a headache for both students and instructors and eats away at precious learning time. OCSdata bridges the gap from web-browser to IDE, allowing users to automatically download the data they need without leaving R. 
