#' Download CO2 Emissions Data
#'
#' Download the CO2 Emissions case study data into a new folder in your current working directory.
#'
#' @details This function downloads the OCS CO2 emissions case study data
#' from GitHub and saves it in a new '/data' folder in your current working directory. This makes
#' it so all of the relevant data needed to follow along the lesson is easily available in a local folder.
#'
#' @param outpath character string, path to the directory where the downloaded
#' data folder should be saved to.
#'
#' @return Nothing useful is returned, a data folder will be downloaded and
#' appear in your files.
#'
#' @import tidyverse
#' @importFrom httr GET
#' @importFrom readxl read_excel
#' @importFrom writexl write_xlsx
#' @export
#'
#' @examples flex_load_data('/Users/michael/Desktop/')
#'
flex_load_data <- function(outpath=NULL){
  if (is.null(outpath)) {
    outpath = getwd() # path to working directory
  }
  datapath = file.path(outpath,'data') # path to new data folder directory
  dir.create(datapath) # creating data folder

  # getting repo webpage data
  co2_repo = GET(url="https://api.github.com/repos/opencasestudies/ocs-bp-co2-emissions/git/trees/master?recursive=1")
  paths = content(co2_repo) %>% unlist(recursive = FALSE) %>% map('path') # creating list of just the file paths in the repo
  paths = paths[!sapply(paths,is.null)] # removing null values

  for (fname in paths){
    if (grepl('data/', fname, fixed = TRUE)) { # if file is in the data directory
      if (grepl('.csv', fname, fixed = TRUE)) { # if .csv file

        # download the .csv file
        download.file(paste0("https://raw.githubusercontent.com/opencasestudies/ocs-bp-co2-emissions/master/",fname),
                      destfile = file.path(outpath,fname), method = "curl")

      } else if (grepl('.xlsx', fname, fixed = TRUE)) { # if .xlsx file

        # download the .xlsx file, different method here because files are too large to have a raw.github link
        url = paste0('https://github.com/opencasestudies/ocs-bp-co2-emissions/blob/master/',fname,'?raw=true')

        GET(url, write_disk(tf <- tempfile(fileext = ".xlsx"))) # loading file from url
        file_data = read_excel(tf, sheet = 1)

        write_xlsx(file_data, path = file.path(outpath, fname)) # writing to .xlsx file in data directory
      }
    }
  }
}
