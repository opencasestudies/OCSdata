#' Download Open Case Study Imported Data
#'
#' Download the specified case study imported data to use as you follow along the case study.
#'
#' @details This function downloads the Open Case Study imported data
#' from GitHub and saves it in a new 'data/imported/' folder in
#' the specified directory. This makes it so all the imported data
#' are easily available in a local folder to be processed and wrangled.
#'
#' @param casestudy character string, name of the case study to pull data from.
#' The input name should follow the same naming scheme as the repository on GitHub:
#'
#' Rural and Urban Obesity: ocs-bp-rural-and-urban-obesity
#'
#' Air Pollution: ocs-bp-air-pollution
#'
#' Vaping: ocs-bp-vaping-case-study
#'
#' Opioids: ocs-bp-opioid-rural-urban
#'
#' Right-to-Carry Part 1: ocs-bp-RTC-wrangling
#'
#' Right-to-Carry Part 2: ocs-bp-RTC-analysis
#'
#' Youth Disconnection: ocs-bp-youth-disconnection
#'
#' Youth Mental Health: ocs-bp-youth-mental-health
#'
#' School Shootings: ocs-bp-school-shootings-dashboard
#'
#' CO2 Emissions: ocs-bp-co2-emissions
#'
#' Dietary Behaviors: ocs-bp-diet
#'
#' @param outpath character string, path to the directory where the downloaded
#' data folder should be saved to.
#'
#' @return Nothing useful is returned, a data/imported folder will be downloaded and
#' appear in your directory.
#'
#' @import httr
#' @importFrom purrr map
#' @export
#'
#' @examples load_imported_data('ocs-bp-co2-emissions')
#'
load_imported_data <- function(casestudy, outpath = NULL){
  if (is.null(outpath)) {
    outpath = getwd() # path to working directory
  }
  datapath = file.path(outpath,'data') # path to new data folder directory
  dir.create(datapath) # creating data folder

  importpath = file.path(datapath,'imported') # path to raw data subfolder
  dir.create(importpath)

  # getting repo webpage data
  repo_url = paste0("https://api.github.com/repos/opencasestudies/",
                    casestudy, "/git/trees/master?recursive=1") # creating repo url string
  repo = GET(url=repo_url)
  repocont = content(repo)
  repounlist = unlist(repocont, recursive = FALSE)
  paths = map(repounlist,'path') # creating list of just the file paths in the repo
  paths = paths[!sapply(paths,is.null)] # removing null values

  for (fname in paths){
    if (grepl('data/', fname, fixed = TRUE)) { # if file is in the data directory
      if (grepl('/imported/', fname, fixed = TRUE)) {

        githuburl = paste0('https://github.com/opencasestudies/', casestudy, '/blob/master/',fname,'?raw=true') # github file link

        if (grepl('.csv', fname, fixed = TRUE)) { # if .csv file

          # download the .csv file
          download.file(paste0("https://raw.githubusercontent.com/opencasestudies/",casestudy,"/master/",fname),
                        destfile = file.path(outpath,fname), method = "curl")

        } else if (grepl('.xls', fname, fixed = TRUE)) { # if .xls(x) file

          # download the .xls(x) file
          GET(githuburl, write_disk(file.path(outpath, fname))) # loading file from url and writing to disk

        } else if (grepl('.rda', fname, fixed = TRUE)) { # if .rda file

          # load the r object into the global environment from the .rda file link
          load(url(githuburl), envir = globalenv())

        } else if (grepl('.pdf',fname, fixed = TRUE)) {

          # download the .pdf file
          GET(githuburl, write_disk(file.path(outpath, fname))) # loading file from url and writing to disk

        }
      }
    }
  }
}

