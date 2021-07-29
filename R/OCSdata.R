#' OCSdata: A package for downloading data from the 'Open Case Studies' repository
#'
#' Provides functions to access and download data from the 'Open Case Studies'
#' repository on GitHub. Different functions enable
#' users to grab the data they need at different sections in the case study, as well as
#' download the whole case study repository. All the user needs to do is input the name of
#' the case study being worked on. The package relies on the httr::GET() function to access
#' files through the GitHub API. The functions usethis::use_zip() and usethis::create_from_github()
#' are used to clone and/or download the case study repositories.
#'
#' @section OCSdata functions:
#' raw_data: downloads the data files needed to work on the data import section
#'
#' simpler_import_data: downloads the raw data files in an import friendly format; usually only
#' available when the original raw files are in an uncommon format
#'
#' extra_data: downloads any extra data files that are not used in the case study
#'
#' imported_data: downloads the data files used in the data wrangling and exploration
#' sections, use this function when skipping the data import section
#'
#' wrangled_data: downloads the data files used in the data analysis and visualization
#' sections, use this function when skipping the data wrangling section.
#'
#' clone_ocs: clones the case study repository with git, needs a registered personal access token (PAT)
#'
#' zip_ocs: downloads the case study repository as a zip file and unzips it to a local directory
#'
#' @docType package
#' @name OCSdata
NULL
#> NULL
