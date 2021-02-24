#' Download Open Case Study Simpler Import Data
#'
#' Download the specified case study simpler import data to use as you follow along the case study.
#'
#' @details This function downloads the Open Case Study raw data
#' from GitHub and saves it in a new 'data/simpler_import/' folder in
#' the specified directory. This makes it so all the simpler import data
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
#' @return Nothing useful is returned, a data/simpler_import folder will be downloaded and
#' appear in your directory.
#'
#' @import magrittr
#' @importFrom WriteXLS WriteXLS
#' @importFrom purrr map
#' @importFrom httr GET
#' @importFrom httr content
#' @importFrom readxl read_excel
#' @importFrom stringr str_sub
#' @export
#'
#' @examples load_simpler_import('ocs-bp-co2-emissions')
#'
load_simpler_import <- function(casestudy, outpath = NULL){
  if (is.null(outpath)) {
    outpath = getwd() # path to working directory
  }
  datapath = file.path(outpath,'data') # path to new data folder directory
  dir.create(datapath) # creating data folder

  simportpath = file.path(datapath,'simpler_import') # path to simpler_import data subfolder
  dir.create(simportpath) # creating simpler_import folder

  # getting repo webpage data
  repo_url = paste0("https://api.github.com/repos/opencasestudies/",
                    casestudy, "/git/trees/master?recursive=1") # creating repo url string
  repo = GET(url=repo_url)
  paths = content(repo) %>% unlist(recursive = FALSE) %>% map('path') # creating list of just the file paths in the repo
  paths = paths[!sapply(paths,is.null)] # removing null values

  for (fname in paths){
    if (grepl('data/', fname, fixed = TRUE)) { # if file is in the data directory
      if (grepl('/simpler_import/', fname, fixed = TRUE)) {
        if (grepl('.csv', fname, fixed = TRUE)) { # if .csv file

          # download the .csv file
          download.file(paste0("https://raw.githubusercontent.com/opencasestudies/",casestudy,"/master/",fname),
                        destfile = file.path(outpath,fname), method = "curl")

        } else if (grepl('.xls', fname, fixed = TRUE)) { # if .xls(x) file

          url = paste0('https://github.com/opencasestudies/', casestudy, '/blob/master/',fname,'?raw=true')

          if (str_sub(fname,-1) == 'x') { # if .xlsx

            # download the .xlsx file, different method here because files are too large to have a raw.github link
            GET(url, write_disk(tf <- tempfile(fileext = ".xlsx"))) # loading with temp .xlsx file from url

          } else { # if .xls

            GET(url, write_disk(tf <- tempfile(fileext = ".xls"))) # loading with temp .xls file from url

          }

          file_data = read_excel(tf, sheet = 1) # creating dataframe from file
          WriteXLS(file_data, ExcelFileName = file.path(outpath, fname)) # writing to .xls file in data directory
        }
      }
    }
  }
}

